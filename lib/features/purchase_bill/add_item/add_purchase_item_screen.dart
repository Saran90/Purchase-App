import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchase_app/core/widgets/app_button.dart';
import 'package:purchase_app/features/purchase_bill/models/product_item.dart';

import '../../../core/widgets/app_drop_down.dart';
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
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  _controller.isNewProduct.value
                      ? [appColorGradient3, appColorGradient4]
                      : [appColorGradient1, appColorGradient2],
              begin: Alignment.topLeft,
              stops: [0.5, 1],
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
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
                            Obx(
                              () => Text(
                                _controller.isEdit.value
                                    ? _controller.isNewProduct.value
                                        ? 'Edit new item'
                                        : 'Edit item'
                                    : _controller.isNewProduct.value
                                    ? 'Add new item'
                                    : 'Add item',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap:
                                          () => _controller.onBarcodeClicked(
                                            context,
                                            false,
                                          ),
                                      child: IconTextField(
                                        controller:
                                            _controller.barcodeController,
                                        hint: 'Enter barcode',
                                        textInputType: TextInputType.text,
                                        whiteBackground: false,
                                        label: 'Barcode',
                                        isEnabled: false,
                                        suffixIcon:
                                            'assets/icons/ic_barcode.png',
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        _controller.showAddNewBarcodeView.value,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 20),
                                        InkWell(
                                          onTap:
                                              _controller
                                                  .onAddNewBarcodeClicked,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: _controller.isImported.value,
                                child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(width: Get.width, height: 80),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => Visibility(
                            visible: _controller.showNewBarcodeView.value,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap:
                                      () => _controller.onBarcodeClicked(
                                        context,
                                        true,
                                      ),
                                  child: IconTextField(
                                    controller:
                                        _controller.newBarcodeController,
                                    hint: 'Enter barcode',
                                    textInputType: TextInputType.text,
                                    whiteBackground: false,
                                    label: 'New Barcode',
                                    isEnabled: false,
                                    suffixIcon: 'assets/icons/ic_barcode.png',
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                       Obx(() => Stack(
                         children: [
                           _controller.isNewProduct.value
                               ? IconTextField(
                             controller: _controller.nameController,
                             hint: 'Enter name',
                             textInputType: TextInputType.text,
                             whiteBackground: false,
                             label: 'Name',
                           )
                               : Obx(
                                 () => AutocompleteTextField<ProductItem>(
                               controller: _controller.nameController,
                               getSuggestions:
                               _controller.getProductSuggestions,
                               onSelected: _controller.onProductItemSelected,
                               suggestions: _controller.productItems,
                               selectedValue:
                               _controller.selectedProductItem.value,
                               label: 'Name',
                               focusNode: _controller.nameFocusNode,
                             ),
                           ),
                           Visibility(
                             visible: _controller.isImported.value,
                             child: InkWell(
                               onTap: () {},
                               child: SizedBox(
                                 width: Get.width,
                                 height: 80,
                               ),
                             ),
                           ),
                         ],
                       ),),
                        const SizedBox(height: 20),
                        Obx(() => Stack(
                          children: [
                            IconTextField(
                              controller: _controller.packagingController,
                              hint: 'Enter packing',
                              textInputType: TextInputType.text,
                              whiteBackground: false,
                              label: 'Packing',
                            ),
                            Visibility(
                              visible: _controller.isImported.value,
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: Get.width,
                                  height: 80,
                                ),
                              ),
                            ),
                          ],
                        ),),
                        const SizedBox(height: 20),
                        Obx(() => Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: IconTextField(
                                    focusNode: _controller.quantityFocusNode,
                                    controller: _controller.quantityController,
                                    hint: 'Enter quantity',
                                    textInputType: TextInputType.numberWithOptions(
                                      signed: false,
                                      decimal: true,
                                    ),
                                    whiteBackground: false,
                                    label: 'Quantity',
                                    formatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'(^\-?\d*\.?\d*)'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: IconTextField(
                                    controller: _controller.freeQuantityController,
                                    hint: 'Enter free quantity',
                                    textInputType: TextInputType.numberWithOptions(
                                      signed: false,
                                      decimal: true,
                                    ),
                                    whiteBackground: false,
                                    label: 'Free Quantity',
                                    formatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'(^\-?\d*\.?\d*)'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: _controller.isImported.value,
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: Get.width,
                                  height: 80,
                                ),
                              ),
                            ),
                          ],
                        ),),
                        const SizedBox(height: 20),
                        Obx(() => Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: IconTextField(
                                    controller: _controller.mrpController,
                                    hint: 'Enter mrp',
                                    textInputType: TextInputType.numberWithOptions(
                                      signed: false,
                                      decimal: true,
                                    ),
                                    whiteBackground: false,
                                    label: 'MRP',
                                    formatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'(^\-?\d*\.?\d*)'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Obx(
                                        () =>
                                    _controller.isNewProduct.value
                                        ? AppDropDown(
                                      items: _controller.taxSlabs,
                                      hint: 'Select',
                                      label: 'Tax Percentage',
                                      selectedValue:
                                      _controller
                                          .selectedTaxSlab
                                          .value ??
                                          0,
                                      onValueSelected:
                                      _controller.onTaxSlabSelected,
                                    )
                                        : SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: _controller.isImported.value,
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: Get.width,
                                  height: 80,
                                ),
                              ),
                            ),
                          ],
                        ),),
                        Obx(() => Stack(
                          children: [
                            Visibility(
                              visible: _controller.isNewProduct.value,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  IconTextField(
                                    controller: _controller.hsnCodeController,
                                    hint: 'Enter hsn code',
                                    textInputType: TextInputType.text,
                                    whiteBackground: false,
                                    label: 'HSN Code',
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: _controller.isImported.value,
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: Get.width,
                                  height: 80,
                                ),
                              ),
                            ),
                          ],
                        ),),
                        const SizedBox(height: 40),
                        Obx(
                          () => AppButton(
                            label: _controller.isEdit.value ? 'Update' : 'Add',
                            onSubmit: _controller.onSaved,
                            startColor:
                                _controller.isNewProduct.value
                                    ? appColorGradient3
                                    : appColorGradient1,
                            endColor:
                                _controller.isNewProduct.value
                                    ? appColorGradient4
                                    : appColorGradient2,
                          ),
                        ),
                      ],
                    ),
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
