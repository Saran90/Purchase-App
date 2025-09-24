import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:purchase_app/api/purchase/models/delete_purchase_request.dart';
import 'package:purchase_app/api/purchase/purchase_api.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_bill.dart';
import 'package:purchase_app/main.dart';
import 'package:purchase_app/utils/extensions.dart';
import 'package:toastification/toastification.dart';

import '../../../api/error_response.dart';
import '../../../data/error/failures.dart';
import '../../../utils/messages.dart';
import '../../../utils/routes.dart';
import '../../../utils/utility_functions.dart';

class PurchaseBillsController extends GetxController {
  final PurchaseApi purchaseApi = Get.find();
  RxBool isLoading = false.obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  RxInt supplierId = 150.obs;
  RxString firmName = ''.obs;
  RxList<PurchaseBill> purchaseBills = RxList([]);

  @override
  void onInit() {
    firmName.value = appStorage.getFirmName() ?? '';
    loadPurchaseBills();
    super.onInit();
  }

  Future<void> loadPurchaseBills() async {
    isLoading.value = true;
    var result = await purchaseApi.getPurchaseBills();
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
          purchaseBills.value =
              r.dataList
                  ?.map(
                    (e) => PurchaseBill(
                      supplierName: e.supplierName,
                      purchaseNo: e.purchaseNo?.toInt(),
                      purchaseId: e.purchaseId?.toInt(),
                      purchaseDate: e.purchaseDate?.toDate(),
                      invoiceDate: e.invoiceDate?.toDate(),
                      billAmount: e.billAmount?.toDouble(),
                      invoiceNo: e.invoiceNo,
                      isImported: e.isImported,
                      supplierId: e.supplierId?.toInt(),
                      // items: e.items
                    ),
                  )
                  .toList() ??
              [];
        } else {
          showToast(message: networkFailureMessage);
        }
        isLoading.value = false;
      },
    );
  }

  Future<void> onAddClicked() async {
    await Get.toNamed(addPurchaseBillRoute);
    loadPurchaseBills();
  }

  Future<void> onBillClicked(PurchaseBill purchaseBill) async {
    await Get.toNamed(addPurchaseBillRoute, arguments: purchaseBill.purchaseId);
    loadPurchaseBills();
  }

  Future<void> onItemDeleteClicked(PurchaseBill purchaseBill) async {
    showDeleteConfirmationDialog(
      purchaseBill,
      () async {
        Get.back();
        isLoading.value = true;
        var result = await purchaseApi.deletePurchase(
          DeletePurchaseRequest(purchaseId: purchaseBill.purchaseId),
        );
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
              showToast(
                message: 'Bill deleted',
                type: ToastificationType.success,
              );
              loadPurchaseBills();
            } else {
              showToast(message: networkFailureMessage);
            }
            isLoading.value = false;
          },
        );
      },
      () {
        Get.back();
      },
    );
  }

  void showDeleteConfirmationDialog(
    PurchaseBill item,
    Function() onOkClicked,
    Function() onCancelClicked,
  ) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Bill"),
          content: Text("Do you really want to delete this bill?"),
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

  void onMenuClicked(BuildContext context, int value) {
    if (value == 0) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Do you really want to logout?"),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  Get.back();
                  appStorage.clear();
                  appStorage.setLoginStatus(status: false);
                  Get.offAllNamed(loginRoute);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
