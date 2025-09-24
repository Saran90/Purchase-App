import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_app/features/purchase_bill/list/purchase_bills_controller.dart';
import '../../../utils/colors.dart';
import '../widgets/purchase_bill_widget.dart';

class PurchaseBillsScreen extends StatelessWidget {
  PurchaseBillsScreen({super.key});

  final _controller = Get.find<PurchaseBillsController>();
  final textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.onAddClicked,
        child: Icon(Icons.add),
      ),
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
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Obx(
                                () => Text(
                                  _controller.firmName.value,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: PopupMenuButton(
                              color: Colors.white,
                              surfaceTintColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.only(left: 20),
                              position: PopupMenuPosition.under,
                              onSelected:
                                  (value) =>
                                      _controller.onMenuClicked(context, value),
                              itemBuilder: (BuildContext bc) {
                                return [
                                  PopupMenuItem(
                                    padding: EdgeInsets.zero,
                                    value: 0,
                                    child: Container(
                                      height: 44,
                                      padding: EdgeInsets.zero,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black38,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Logout',
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: const Icon(
                                  Icons.settings,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Purchase Bills',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            itemCount: _controller.purchaseBills.length,
                            itemBuilder:
                                (context, index) => InkWell(
                                  onTap:
                                      () => _controller.onBillClicked(
                                        _controller.purchaseBills[index],
                                      ),
                                  child: PurchaseItemWidget(
                                    purchaseBill:
                                        _controller.purchaseBills[index],
                                    onDeleteClicked:
                                        () => _controller.onItemDeleteClicked(
                                          _controller.purchaseBills[index],
                                        ),
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ],
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
