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
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: PopupMenuButton(
                              //     color: Colors.white,
                              //     surfaceTintColor: Colors.transparent,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     padding: EdgeInsets.zero,
                              //     position: PopupMenuPosition.under,
                              //     onSelected:
                              //         (value) => _controller.onMenuClicked(
                              //           context,
                              //           value,
                              //         ),
                              //     itemBuilder: (BuildContext bc) {
                              //       return [
                              //         PopupMenuItem(
                              //           padding: EdgeInsets.zero,
                              //           value: 0,
                              //           child: Container(
                              //             height: 44,
                              //             padding: EdgeInsets.zero,
                              //             decoration: const BoxDecoration(
                              //               border: Border(
                              //                 bottom: BorderSide(
                              //                   color: Colors.black38,
                              //                   width: 1,
                              //                 ),
                              //               ),
                              //             ),
                              //             child: Center(
                              //               child: Text(
                              //                 'Report',
                              //                 style: const TextStyle(
                              //                   color: Colors.black87,
                              //                   fontSize: 14,
                              //                   fontWeight: FontWeight.w500,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         PopupMenuItem(
                              //           value: 1,
                              //           child: Container(
                              //             height: 44,
                              //             padding: EdgeInsets.zero,
                              //             child: Center(
                              //               child: Text(
                              //                 'Reset Password',
                              //                 style: const TextStyle(
                              //                   color: Colors.black87,
                              //                   fontSize: 14,
                              //                   fontWeight: FontWeight.w500,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ];
                              //     },
                              //     icon: Padding(
                              //       padding: const EdgeInsets.only(bottom: 10),
                              //       child: const Icon(
                              //         Icons.settings,
                              //         size: 20,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                            () => AutocompleteTextField<Supplier>(
                              controller: _controller.supplierController,
                              getSuggestions:
                                  _controller.getSupplierSuggestions,
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
                          const SizedBox(height: 20),
                          InkWell(
                            onTap:
                                () => _controller.onInvoiceDateClicked(context),
                            child: IconTextField(
                              controller: _controller.invoiceDateController,
                              hint: 'Enter invoice date',
                              textInputType: TextInputType.text,
                              whiteBackground: false,
                              label: 'Invoice Date',
                              isEnabled: false,
                              suffixIcon: 'assets/icons/ic_calendar.png',
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap:
                                () =>
                                    _controller.onPurchaseDateClicked(context),
                            child: IconTextField(
                              controller: _controller.purchaseDateController,
                              hint: 'Enter purchase date',
                              textInputType: TextInputType.text,
                              whiteBackground: false,
                              label: 'Purchase Date',
                              isEnabled: false,
                              suffixIcon: 'assets/icons/ic_calendar.png',
                            ),
                          ),
                          const SizedBox(height: 20),
                          IconTextField(
                            controller: _controller.amountController,
                            hint: 'Enter amount',
                            textInputType: TextInputType.number,
                            whiteBackground: false,
                            label: 'Amount',
                            icon: 'assets/icons/ic_rupee.png',
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
                              const SizedBox(width: 20,),
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
                            constraints: BoxConstraints(
                              minHeight: 100
                            ),
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
                                      () => _controller.onItemClicked(
                                    _controller.items[index],
                                  ),
                                  child: PurchaseItemWidget(
                                    purchaseItem:
                                    _controller.items[index],
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
                          )
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
