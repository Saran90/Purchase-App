import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_app/features/purchase_bill/models/supplier.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/widgets/autocomplete_textfield.dart';
import '../../../core/widgets/icon_text_field.dart';
import '../../../utils/colors.dart';
import 'add_purchase_bill_controller.dart';

class AddPurchaseBillScreen extends StatelessWidget {
  AddPurchaseBillScreen({super.key});

  final _controller = Get.find<AddPurchaseBillController>();
  final textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appColorGradient1, appColorGradient2],
            begin: Alignment.topLeft,
            stops: [0.5, 1],
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Obx(
                  () => AutocompleteTextField<Supplier>(
                    controller: _controller.supplierController,
                    getSuggestions: _controller.getSupplierSuggestions,
                    onSelected: _controller.onSupplierSelected,
                    suggestions: _controller.suppliers,
                    selectedValue: _controller.selectedSupplier.value,
                    label: 'Supplier',
                  ),
                ),
                const SizedBox(height: 20),
                IconTextField(
                  controller: _controller.invoiceNumberController,
                  hint: 'Enter invoice number',
                  textInputType: TextInputType.text,
                  whiteBackground: false,
                  label: 'Invoice Number',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
