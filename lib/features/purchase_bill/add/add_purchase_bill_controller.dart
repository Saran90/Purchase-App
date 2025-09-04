import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purchase_app/features/purchase_bill/models/supplier.dart';

class AddPurchaseBillController extends GetxController {
  final supplierController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  RxList<Supplier> suppliers = RxList([
    Supplier(id: 1, name: 'Supplier 1'),
    Supplier(id: 2, name: 'Supplier 2'),
    Supplier(id: 3, name: 'Supplier 3'),
  ]);
  Rx<Supplier?> selectedSupplier = Rx<Supplier?>(null);

  Future<List<Supplier>> getSupplierSuggestions(String pattern) async {
    // In a real app, you might fetch suggestions from an API here
    await Future.delayed(Duration(milliseconds: 200)); // Simulate network delay
    if (pattern.isEmpty || pattern.length < 4) {
      return [];
    }
    return suppliers.where((item) {
      return item.name.toLowerCase().contains(pattern.toLowerCase());
    }).toList();
  }

  void onAddPurchaseBillClicked() {}

  void onSupplierSelected(Supplier supplier) {
    selectedSupplier.value = supplier;
  }
}
