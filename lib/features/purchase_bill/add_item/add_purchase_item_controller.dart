import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:purchase_app/api/purchase/purchase_api.dart';
import 'package:purchase_app/features/purchase_bill/models/product_item.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';
import 'package:purchase_app/features/purchase_bill/models/supplier.dart';
import 'package:purchase_app/utils/extensions.dart';
import 'package:purchase_app/utils/utility_functions.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../api/error_response.dart';
import '../../../data/error/failures.dart';
import '../../../utils/messages.dart';

class AddPurchaseItemController extends GetxController {
  final barcodeController = TextEditingController();
  final hsnCodeController = TextEditingController();
  final taxPercentageController = TextEditingController();
  final nameController = TextEditingController();
  final packagingController = TextEditingController();
  final mrpController = TextEditingController();
  final totalItemsController = TextEditingController();
  final quantityController = TextEditingController();
  final freeQuantityController = TextEditingController();
  final PurchaseApi purchaseApi = Get.find();

  Rx<ProductItem?> selectedProductItem = Rx<ProductItem?>(null);
  RxList<ProductItem> productItems = RxList([]);
  RxBool isLoading = false.obs;
  RxInt purchaseId = 0.obs;
  RxInt rowNumber = 0.obs;
  late FocusNode quantityFocusNode;
  late FocusNode nameFocusNode;
  RxBool isNewProduct = false.obs;
  RxList<double> taxSlabs = RxList<double>();
  Rx<double?> selectedTaxSlab = Rx<double?>(null);
  RxBool isEdit = RxBool(false);
  Rx<PurchaseItem?> purchaseItem = Rx<PurchaseItem?>(null);

  @override
  void onInit() {
    print('onInit');
    getTaxSlabs();
    isEdit.value = false;
    quantityFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    var value = Get.arguments as List<dynamic>;
    if (value[1] != null) {
      isNewProduct.value = value[1] as bool;
    }
    PurchaseItem? item = value[0] as PurchaseItem?;
    if (item != null) {
      purchaseItem.value = item;
      isEdit.value = true;
      nameController.text = item.name;
      packagingController.text = item.packaging;
      mrpController.text = item.price.toString();
      barcodeController.text = item.barcode;
      quantityController.text = item.quantity.toString();
      freeQuantityController.text = item.freeQuantity.toString();
      purchaseId.value = item.id;
      rowNumber.value = item.rowNumber;
      hsnCodeController.text = item.hsnCode;
      selectedTaxSlab.value = item.taxPercentage;
      print('Selected Tax: ${selectedTaxSlab.value}');
      taxPercentageController.text = item.taxPercentage.toString();
      isNewProduct.value = item.isNew;
      if (item.id != 0) {
        isNewProduct.value = false;
      } else {
        isNewProduct.value = true;
      }

      Future.delayed(
        Duration(milliseconds: 200),
            () => Get.focusScope?.unfocus(),
      );
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        onBarcodeClicked(Get.context!);
      });
    }
    super.onInit();
  }

  Future<List<ProductItem>> getProductSuggestions(String pattern) async {
    if (pattern.isEmpty || pattern.length < 3) {
      return [];
    }
    var result = await purchaseApi.getProducts(name: pattern);
    result.fold((l) {}, (r) {
      if (r != null) {
        productItems.value =
            r.dataList
                ?.map(
                  (e) =>
                  ProductItem(
                    id: e.productId?.toInt() ?? 0,
                    name: e.productName ?? '',
                    mrp: e.mrp?.toDouble() ?? 0,
                    barCode: e.barCode ?? '',
                    packing: e.packing ?? '',
                  ),
            )
                .toList() ??
                [];
        return productItems;
      } else {
        productItems.value = [];
        return [];
      }
    });
    return productItems;
  }

  void onProductItemSelected(ProductItem item) {
    selectedProductItem.value = item;
    packagingController.text = item.packing;
    mrpController.text = item.mrp.toString();
    barcodeController.text = item.barCode;
    purchaseId.value = item.id;
    quantityFocusNode.requestFocus();
  }

  Future<void> onBarcodeClicked(BuildContext context) async {
    String? res = await SimpleBarcodeScanner.scanBarcode(
      Get.context!,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Barcode',
        centerTitle: false,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      cameraFace: CameraFace.back,
    );
    if (res != null) {
      if (res == '-1') {
        res = '';
        nameFocusNode.requestFocus();
      }
      barcodeController.text = res;
      if (res.isNotEmpty) {
        getProductByBarcode(res);
      }
    }
  }

  void onSaved() {
    if (nameController.text.isNotEmpty) {
      if (mrpController.text.isNotEmpty) {
        if ((quantityController.text.isEmpty ||
            quantityController.text == '0') &&
            (freeQuantityController.text.isEmpty ||
                freeQuantityController.text == '0')) {
          showToast(
            message: 'Both Quantity and free quantity cannot be empty or 0',
          );
        } else {
          if (isNewProduct.value) {
            if (hsnCodeController.text.isEmpty) {
              showToast(message: 'HSN code should not be empty');
            } else {
              Get.back(
                result: PurchaseItem(
                  id: purchaseId.value,
                  name: nameController.text,
                  packaging: packagingController.text,
                  barcode: barcodeController.text,
                  price: mrpController.text.toDouble() ?? 0,
                  freeQuantity: freeQuantityController.text.toInt() ?? 0,
                  quantity: quantityController.text.toInt() ?? 0,
                  rowNumber: rowNumber.value,
                  hsnCode: hsnCodeController.text,
                  taxPercentage: selectedTaxSlab.value ?? 0,
                  isNew: isNewProduct.value,
                ),
              );
            }
          } else {
            Get.back(
              result: PurchaseItem(
                id: purchaseId.value,
                name: nameController.text,
                packaging: packagingController.text,
                barcode: barcodeController.text,
                price: mrpController.text.toDouble() ?? 0,
                freeQuantity: freeQuantityController.text.toInt() ?? 0,
                quantity: quantityController.text.toInt() ?? 0,
                rowNumber: rowNumber.value,
                hsnCode: hsnCodeController.text,
                taxPercentage:
                double.tryParse(taxPercentageController.text) ?? 0,
                isNew: isNewProduct.value,
              ),
            );
          }
        }
      } else {
        showToast(message: 'MRP should not be empty');
      }
    } else {
      showToast(message: 'Name should not be empty');
    }
  }

  void onBackClicked() {
    Get.back();
  }

  Future<void> getProductByBarcode(String res) async {
    isLoading.value = false;
    var result = await purchaseApi.getProductByBarcode(res);
    result.fold(
          (l) {
        if (l is APIFailure) {
          ErrorResponse? errorResponse = l.error;
          showToast(message: errorResponse?.message ?? apiFailureMessage);
        } else if (l is ServerFailure) {
          showToast(message: l.message ?? serverFailureMessage);
        } else if (l is AuthFailure) {} else if (l is NetworkFailure) {
          showToast(message: networkFailureMessage);
        } else {
          showToast(message: unknownFailureMessage);
        }
        isLoading.value = false;
      },
          (r) {
        if (r != null) {
          selectedProductItem.value = ProductItem(
            id: r.productId?.toInt() ?? 0,
            name: r.productName ?? '',
            mrp: r.mrp?.toDouble() ?? 0,
            packing: r.packing ?? '',
            barCode: r.barCode ?? '',
          );
          nameController.text = selectedProductItem.value?.name ?? '';
          packagingController.text = selectedProductItem.value?.packing ?? '';
          mrpController.text = selectedProductItem.value?.mrp.toString() ?? '';
          quantityFocusNode.requestFocus();
        } else {}
        isLoading.value = false;
      },
    );
  }

  Future<void> getTaxSlabs() async {
    var result = await purchaseApi.geTaxSlabs();
    result.fold(
          (l) {
        if (l is APIFailure) {
          ErrorResponse? errorResponse = l.error;
          showToast(message: errorResponse?.message ?? apiFailureMessage);
        } else if (l is ServerFailure) {
          showToast(message: l.message ?? serverFailureMessage);
        } else if (l is AuthFailure) {} else if (l is NetworkFailure) {
          showToast(message: networkFailureMessage);
        } else {
          showToast(message: unknownFailureMessage);
        }
        isLoading.value = false;
      },
          (r) {
        taxSlabs.value =
            r?.dataList?.map((e) => e.taxPer?.toDouble() ?? 0).toList() ?? [];
        if (purchaseItem.value != null) {
          selectedTaxSlab.value = purchaseItem.value?.taxPercentage;
        } else {
          selectedTaxSlab.value = taxSlabs.first;
        }
        isLoading.value = false;
        selectedTaxSlab.refresh();
      },
    );
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  onTaxSlabSelected(double? value) {
    selectedTaxSlab.value = value;
  }
}
