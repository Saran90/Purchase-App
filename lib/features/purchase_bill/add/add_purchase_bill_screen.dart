import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_app/core/widgets/app_button.dart';
import 'package:purchase_app/features/purchase_bill/models/supplier.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/widgets/autocomplete_textfield.dart';
import '../../../core/widgets/icon_text_field.dart';
import '../../../utils/colors.dart';
import '../widgets/purchase_item_widget.dart';
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => _controller.onBackClicked(),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Obx(
                              () => Text(
                                _controller.purchaseId.value == 0
                                    ? 'Add Purchase Bill'
                                    : _controller.invoiceNumber.value,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => Stack(
                              children: [
                                AutocompleteTextField<Supplier>(
                                  controller: _controller.supplierController,
                                  getSuggestions:
                                      _controller.getSupplierSuggestions,
                                  onSelected: _controller.onSupplierSelected,
                                  suggestions: _controller.suppliers,
                                  selectedValue:
                                      _controller.selectedSupplier.value,
                                  label: 'Supplier',
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
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => Stack(
                              children: [
                                IconTextField(
                                  controller:
                                      _controller.invoiceNumberController,
                                  hint: 'Enter invoice number',
                                  textInputType: TextInputType.text,
                                  whiteBackground: false,
                                  label: 'Invoice Number',
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
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => Stack(
                              children: [
                                InkWell(
                                  onTap:
                                      () => _controller.onInvoiceDateClicked(
                                        context,
                                      ),
                                  child: IconTextField(
                                    controller:
                                        _controller.invoiceDateController,
                                    hint: 'Enter invoice date',
                                    textInputType: TextInputType.text,
                                    whiteBackground: false,
                                    label: 'Invoice Date',
                                    isEnabled: false,
                                    suffixIcon: 'assets/icons/ic_calendar.png',
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
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => Stack(
                              children: [
                                InkWell(
                                  onTap:
                                      () => _controller.onPurchaseDateClicked(
                                        context,
                                      ),
                                  child: IconTextField(
                                    controller:
                                        _controller.purchaseDateController,
                                    hint: 'Enter purchase date',
                                    textInputType: TextInputType.text,
                                    whiteBackground: false,
                                    label: 'Purchase Date',
                                    isEnabled: false,
                                    suffixIcon: 'assets/icons/ic_calendar.png',
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
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => Stack(
                              children: [
                                IconTextField(
                                  controller: _controller.amountController,
                                  hint: 'Enter amount',
                                  textInputType: TextInputType.number,
                                  whiteBackground: false,
                                  label: 'Amount',
                                  icon: 'assets/icons/ic_rupee.png',
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
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Items',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  '${_controller.items.length} count',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppButton(
                                  label: 'Add item',
                                  onSubmit: _controller.onAddClicked,
                                  startColor: appColorGradient1,
                                  endColor: appColorGradient2,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: AppButton(
                                  label: 'Add new item',
                                  onSubmit: _controller.onAddNewClicked,
                                  startColor: appColorGradient3,
                                  endColor: appColorGradient4,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 100),
                            child: Obx(
                              () =>
                                  _controller.items.isEmpty
                                      ? Center(
                                        child: Text(
                                          'No items added',
                                          style: TextStyle(color: textColor),
                                        ),
                                      )
                                      : ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: _controller.items.length,
                                        itemBuilder:
                                            (context, index) => InkWell(
                                              onTap:
                                                  () =>
                                                      _controller.onItemClicked(
                                                        _controller
                                                            .items[index],
                                                      ),
                                              child: PurchaseItemWidget(
                                                purchaseItem:
                                                    _controller.items[index],
                                                isImported:
                                                    _controller
                                                        .isImported
                                                        .value,
                                                onDeleteClicked:
                                                    () => _controller
                                                        .onDeleteProductClicked(
                                                          _controller
                                                              .items[index],
                                                        ),
                                              ),
                                            ),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: AppButton(
                      label: 'Save',
                      onSubmit: _controller.onSaveClicked,
                      startColor: appColorGradient1,
                      endColor: appColorGradient2,
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: _controller.isLoading.value,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
