import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';
import 'package:purchase_app/features/purchase_bill/models/supplier.dart';
import 'package:purchase_app/utils/extensions.dart';
import 'package:purchase_app/utils/routes.dart';

class AddPurchaseBillController extends GetxController {
  final supplierController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final invoiceDateController = TextEditingController();
  final amountController = TextEditingController();
  RxList<Supplier> suppliers = RxList([
    Supplier(id: 1, name: 'Supplier 1'),
    Supplier(id: 2, name: 'Supplier 2'),
    Supplier(id: 3, name: 'Supplier 3'),
  ]);
  Rx<Supplier?> selectedSupplier = Rx<Supplier?>(null);
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  RxList<PurchaseItem> items = RxList<PurchaseItem>();

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

  Future<void> onDateClicked(BuildContext context) async {
    final date = await showDatePickerDialog(
      context: context,
      selectedDate: selectedDate.value,
      minDate: DateTime(1950, 1, 1),
      maxDate: DateTime(2500, 12, 31),
    );
    invoiceDateController.text = date?.toDDMMYYYY() ?? '';
  }

  Future<void> onAddClicked() async {
    PurchaseItem? item =
        await Get.toNamed(addPurchaseItemRoute) as PurchaseItem?;
    if (item != null) {
      items.add(item);
    }
  }

  void onSaveClicked() {}

  void onMenuClicked(BuildContext context, int value) {}
}
