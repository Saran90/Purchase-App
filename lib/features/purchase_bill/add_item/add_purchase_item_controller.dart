import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Future<List<ProductItem>> getProductSuggestions(String pattern) async {
    if (pattern.isEmpty || pattern.length < 4) {
      return [];
    }
    var result = await purchaseApi.getProducts(name: pattern);
    result.fold((l) {}, (r) {
      if (r != null) {
        productItems.value =
            r.dataList
                ?.map(
                  (e) => ProductItem(
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
  }

  Future<void> onBarcodeClicked(BuildContext context) async {
    String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
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
      }
      barcodeController.text = res;
      if (res.isNotEmpty) {
        getProductByBarcode(res);
      }
    }
  }

  void onSaved() {
    Get.back(
      result: PurchaseItem(
        id: selectedProductItem.value?.id ?? 0,
        name: nameController.text,
        packaging: packagingController.text,
        barcode: barcodeController.text,
        price: mrpController.text.toDouble() ?? 0,
        freeQuantity: freeQuantityController.text.toInt() ?? 0,
        quantity: quantityController.text.toInt() ?? 0,
        rowNumber: 0,
      ),
    );
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
        } else {}
        isLoading.value = false;
      },
    );
  }
}
