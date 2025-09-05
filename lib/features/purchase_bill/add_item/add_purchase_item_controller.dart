import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_app/features/purchase_bill/models/product_item.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';
import 'package:purchase_app/features/purchase_bill/models/supplier.dart';
import 'package:purchase_app/utils/extensions.dart';
import 'package:purchase_app/utils/utility_functions.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddPurchaseItemController extends GetxController {
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final packagingController = TextEditingController();
  final mrpController = TextEditingController();
  final totalItemsController = TextEditingController();
  final quantityController = TextEditingController();
  final freeQuantityController = TextEditingController();

  Rx<ProductItem?> selectedProductItem = Rx<ProductItem?>(null);
  RxList<ProductItem> productItems = RxList([
    ProductItem(id: 1, name: 'Product 1'),
    ProductItem(id: 2, name: 'Product 2'),
    ProductItem(id: 3, name: 'Product 3'),
  ]);

  Future<List<ProductItem>> getProductSuggestions(String pattern) async {
    // In a real app, you might fetch suggestions from an API here
    await Future.delayed(Duration(milliseconds: 200)); // Simulate network delay
    if (pattern.isEmpty || pattern.length < 4) {
      return [];
    }
    return productItems.where((item) {
      return item.name.toLowerCase().contains(pattern.toLowerCase());
    }).toList();
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
      cameraFace: CameraFace.front,
    );
    barcodeController.text = res as String;
  }

  void onSaved() {
    Get.back(
      result: PurchaseItem(
        id: getRandomId(),
        name: nameController.text,
        packaging: packagingController.text,
        barcode: barcodeController.text,
        price: mrpController.text.toDouble() ?? 0,
        freeQuantity: freeQuantityController.text.toInt() ?? 0,
        quantity: quantityController.text.toInt() ?? 0,
        count: totalItemsController.text.toInt() ?? 0,
      ),
    );
  }

  void onBackClicked() {
    Get.back();
  }
}
