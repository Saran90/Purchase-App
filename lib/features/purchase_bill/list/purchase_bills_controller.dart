import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:purchase_app/api/purchase/purchase_api.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_bill.dart';
import 'package:purchase_app/utils/extensions.dart';

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
  RxList<PurchaseBill> purchaseBills = RxList([]);

  @override
  void onInit() {
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
}
