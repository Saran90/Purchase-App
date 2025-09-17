import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_app/api/purchase/models/add_purchase_request.dart';
import 'package:purchase_app/api/purchase/purchase_api.dart';
import 'package:purchase_app/features/purchase_bill/models/product_item.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';
import 'package:purchase_app/features/purchase_bill/models/supplier.dart';
import 'package:purchase_app/main.dart';
import 'package:purchase_app/utils/extensions.dart';
import 'package:purchase_app/utils/routes.dart';
import 'package:toastification/toastification.dart';

import '../../../api/error_response.dart';
import '../../../data/error/failures.dart';
import '../../../utils/messages.dart';
import '../../../utils/utility_functions.dart';

class AddPurchaseBillController extends GetxController {
  final supplierController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final invoiceDateController = TextEditingController();
  final purchaseDateController = TextEditingController();
  final amountController = TextEditingController();
  RxList<Supplier> suppliers = RxList([]);
  Rx<Supplier?> selectedSupplier = Rx<Supplier?>(null);
  Rx<DateTime> selectedInvoiceDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedPurchaseDate = Rx<DateTime>(DateTime.now());
  RxList<PurchaseItem> items = RxList<PurchaseItem>();
  final PurchaseApi purchaseApi = Get.find();
  RxBool isLoading = RxBool(false);
  RxInt purchaseId = 0.obs;
  RxInt purchaseNo = 0.obs;
  RxInt userId = 0.obs;
  RxString invoiceNumber = ''.obs;

  @override
  void onInit() {
    var id = Get.arguments as int?;
    if (id != null) {
      purchaseId.value = id;
    }
    invoiceDateController.text = selectedInvoiceDate.value.toDDMMYYYY() ?? '';
    purchaseDateController.text = selectedPurchaseDate.value.toDDMMYYYY() ?? '';
    getPurchase();
    userId.value = 1;
    super.onInit();
  }

  Future<List<Supplier>> getSupplierSuggestions(String pattern) async {
    if (pattern.isEmpty || pattern.length < 3) {
      return [];
    }
    var result = await purchaseApi.getSuppliers(name: pattern);
    result.fold((l) {}, (r) {
      if (r != null) {
        suppliers.value =
            r.dataList
                ?.map(
                  (e) => Supplier(
                    id: e.supplierId?.toInt() ?? 0,
                    name: e.supplierName ?? '',
                  ),
                )
                .toList() ??
            [];
        return suppliers;
      } else {
        suppliers.value = [];
        return [];
      }
    });
    return suppliers;
  }

  void onAddPurchaseBillClicked() {}

  void onSupplierSelected(Supplier supplier) {
    selectedSupplier.value = supplier;
  }

  Future<void> onInvoiceDateClicked(BuildContext context) async {
    final date = await showDatePickerDialog(
      context: context,
      selectedDate: selectedInvoiceDate.value,
      minDate: DateTime(1950, 1, 1),
      maxDate: DateTime(2500, 12, 31),
    );
    if (date != null) {
      selectedInvoiceDate.value = date;
      invoiceDateController.text = date.toDDMMYYYY() ?? '';
    }
  }

  Future<void> onPurchaseDateClicked(BuildContext context) async {
    final date = await showDatePickerDialog(
      context: context,
      selectedDate: selectedPurchaseDate.value,
      minDate: DateTime(1950, 1, 1),
      maxDate: DateTime(2500, 12, 31),
    );
    if (date != null) {
      selectedPurchaseDate.value = date;
      purchaseDateController.text = date.toDDMMYYYY() ?? '';
    }
  }

  Future<void> onAddClicked() async {
    var item = await Get.toNamed(addPurchaseItemRoute) as PurchaseItem?;
    onItemAdded(item);
  }

  void onItemAdded(PurchaseItem? item) {
    if (item != null) {
      if (_isAlreadyAdded(item)) {
        if (_hasDifferentMrp(item)) {
          showDuplicatePriceProductDialog(
            item,
            () {
              Get.back();
              items.add(item);
              update();
            },
            () {
              Get.back();
            },
          );
        } else {
          showDuplicateProductDialog(
            item,
            () {
              Get.back();
              for (int i = 0; i < items.length; i++) {
                if (items[i].id == item.id) {
                  items[i].quantity += item.quantity;
                  items[i].freeQuantity += item.freeQuantity;
                  break;
                }
              }
              items.refresh();
            },
            () {
              Get.back();
            },
          );
        }
      } else {
        items.add(item);
      }
    }
  }

  Future<void> onSaveClicked() async {
    if (selectedSupplier.value != null &&
        invoiceNumberController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      AddPurchaseRequest addPurchaseRequest = AddPurchaseRequest(
        invoiceNo: invoiceNumberController.value.text,
        billAmount: amountController.value.text.toDouble() ?? 0,
        invoiceDate: selectedInvoiceDate.value.toYYYYMMDD(),
        supplierId: selectedSupplier.value?.id ?? 0,
        purchaseDate: selectedPurchaseDate.value.toYYYYMMDD(),
        purchaseId: purchaseId.value,
        purchaseNo: purchaseNo.value,
        userId: userId.value,
        supplierName: selectedSupplier.value?.name,
        itemsList:
            items
                .map(
                  (element) => Items(
                    rowNumber: element.rowNumber,
                    quantity: element.quantity,
                    freeQuantity: element.freeQuantity,
                    mrp: element.price,
                    productId: element.id,
                    productName: element.name,
                    purchaseDetailId: 0,
                  ),
                )
                .toList(),
      );
      var result = await purchaseApi.addPurchase(addPurchaseRequest);
      result.fold(
        (l) {
          if (l is APIFailure) {
            ErrorResponse? errorResponse = l.error;
            showToast(message: errorResponse?.message ?? apiFailureMessage);
          } else if (l is ServerFailure) {
            showToast(message: l.message ?? serverFailureMessage);
          } else if (l is AuthFailure) {
          } else if (l is NetworkFailure) {
            showToast(message: networkFailureMessage);
          } else {
            showToast(message: unknownFailureMessage);
          }
          isLoading.value = false;
        },
        (r) {
          if (r != null) {
            purchaseId.value = r.purchaseId ?? 0;
            showToast(
              message: 'Purchase updated',
              type: ToastificationType.success,
            );
            Get.back();
          } else {
            showToast(message: networkFailureMessage);
          }
        },
      );
    } else {
      showToast(message: 'Please provide required fields');
    }
  }

  void onMenuClicked(BuildContext context, int value) {}

  Future<void> getPurchase() async {
    isLoading.value = false;
    if (purchaseId.value != 0) {
      var result = await purchaseApi.getPurchaseById(purchaseId.value);
      result.fold(
        (l) {
          if (l is APIFailure) {
            ErrorResponse? errorResponse = l.error;
            showToast(message: errorResponse?.message ?? apiFailureMessage);
          } else if (l is ServerFailure) {
            showToast(message: l.message ?? serverFailureMessage);
          } else if (l is AuthFailure) {
          } else if (l is NetworkFailure) {
            showToast(message: networkFailureMessage);
          } else {
            showToast(message: unknownFailureMessage);
          }
          isLoading.value = false;
        },
        (r) {
          if (r != null) {
            selectedSupplier.value = Supplier(
              id: r.supplierId?.toInt() ?? 0,
              name: r.supplierName ?? '',
            );
            supplierController.text = r.supplierName ?? '';
            invoiceNumberController.text = r.invoiceNo ?? '';
            invoiceNumber.value = r.invoiceNo ?? '';
            selectedInvoiceDate.value =
                r.invoiceDate?.toDate() ?? DateTime.now();
            selectedPurchaseDate.value =
                r.purchaseDate?.toDate() ?? DateTime.now();
            purchaseId.value = r.purchaseId?.toInt() ?? 0;
            purchaseNo.value = r.purchaseNo?.toInt() ?? 0;
            invoiceDateController.text = selectedInvoiceDate.value.toDDMMYYYY();
            purchaseDateController.text =
                selectedPurchaseDate.value.toDDMMYYYY();
            amountController.text = r.billAmount?.toString() ?? '';
            if (r.itemsList != null) {
              items.value =
                  r.itemsList
                      ?.map(
                        (e) => PurchaseItem(
                          id: e.productId?.toInt() ?? 0,
                          name: e.productName ?? '',
                          packaging: e.packing ?? '',
                          barcode: '',
                          rowNumber: e.rowNumber?.toInt() ?? 0,
                          price: e.mrp?.toDouble() ?? 0,
                          freeQuantity: e.freeQuantity?.toInt() ?? 0,
                          quantity: e.quantity?.toInt() ?? 0,
                        ),
                      )
                      .toList() ??
                  [];
            }
            Get.focusScope?.unfocus();
          } else {}
          isLoading.value = false;
        },
      );
    }
  }

  void onBackClicked() {
    Get.back();
  }

  void onDeleteProductClicked(PurchaseItem item) {
    showDeleteConfirmationDialog(
      item,
      () {
        Get.back();
        items.removeWhere(
          (element) => (element.id == item.id) && (element.price == item.price),
        );
      },
      () {
        Get.back();
      },
    );
  }

  bool _isAlreadyAdded(PurchaseItem item) {
    return items.any((element) => element.id == item.id);
  }

  bool _hasDifferentMrp(PurchaseItem item) {
    return items.any(
      (element) => (element.id == item.id) && (element.price != item.price),
    );
  }

  void showDuplicateProductDialog(
    PurchaseItem item,
    Function() onOkClicked,
    Function() onCancelClicked,
  ) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Duplicate Product"),
          content: Text(
            "${item.name} already added. Do you want to update the quantity?",
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                onCancelClicked();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                onOkClicked();
              },
            ),
          ],
        );
      },
    );
  }

  void showDuplicatePriceProductDialog(
    PurchaseItem item,
    Function() onOkClicked,
    Function() onCancelClicked,
  ) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Duplicate Product"),
          content: Text(
            "Product ${item.name} with different MRP already added. Do you want to create a duplicate item with new price?",
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                onCancelClicked();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                onOkClicked();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(
    PurchaseItem item,
    Function() onOkClicked,
    Function() onCancelClicked,
  ) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Product"),
          content: Text("Do you really want to delete this item?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                onCancelClicked();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                onOkClicked();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> onItemClicked(PurchaseItem purchaseItem) async {
    var item =
        await Get.toNamed(addPurchaseItemRoute, arguments: purchaseItem)
            as PurchaseItem?;
    onItemAdded(item);
  }
}
