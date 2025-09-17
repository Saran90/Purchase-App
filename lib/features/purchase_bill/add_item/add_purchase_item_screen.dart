import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchase_app/core/widgets/app_button.dart';
import 'package:purchase_app/features/purchase_bill/models/product_item.dart';

import '../../../core/widgets/autocomplete_textfield.dart';
import '../../../core/widgets/icon_text_field.dart';
import '../../../utils/colors.dart';
import 'add_purchase_item_controller.dart';

class AddPurchaseItemScreen extends StatelessWidget {
  AddPurchaseItemScreen({super.key});

  final _controller = Get.find<AddPurchaseItemController>();
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => _controller.onBackClicked(),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Add item',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () => _controller.onBarcodeClicked(context),
                        child: IconTextField(
                          controller: _controller.barcodeController,
                          hint: 'Enter barcode',
                          textInputType: TextInputType.text,
                          whiteBackground: false,
                          label: 'Barcode',
                          isEnabled: false,
                          suffixIcon: 'assets/icons/ic_barcode.png',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => AutocompleteTextField<ProductItem>(
                          controller: _controller.nameController,
                          getSuggestions: _controller.getProductSuggestions,
                          onSelected: _controller.onProductItemSelected,
                          suggestions: _controller.productItems,
                          selectedValue: _controller.selectedProductItem.value,
                          label: 'Name',
                        ),
                      ),
                      const SizedBox(height: 20),
                      IconTextField(
                        controller: _controller.packagingController,
                        hint: 'Enter packing',
                        textInputType: TextInputType.text,
                        whiteBackground: false,
                        label: 'Packing',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: IconTextField(
                              controller: _controller.quantityController,
                              hint: 'Enter quantity',
                              textInputType: TextInputType.numberWithOptions(signed: false,decimal: true),
                              whiteBackground: false,
                              label: 'Quantity',
                              formatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: IconTextField(
                              controller: _controller.freeQuantityController,
                              hint: 'Enter free quantity',
                              textInputType: TextInputType.numberWithOptions(signed: false,decimal: true),
                              whiteBackground: false,
                              label: 'Free Quantity',
                              formatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: IconTextField(
                              controller: _controller.mrpController,
                              hint: 'Enter mrp',
                              textInputType: TextInputType.numberWithOptions(signed: false,decimal: true),
                              whiteBackground: false,
                              label: 'MRP',
                              formatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        label: 'Add',
                        onSubmit: _controller.onSaved,
                        startColor: appColorGradient1,
                        endColor: appColorGradient2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
