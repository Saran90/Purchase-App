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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Text(
                          'Purchase Bills',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            itemCount: _controller.purchaseBills.length,
                            itemBuilder:
                                (context, index) => InkWell(
                                  onTap: () => _controller.onBillClicked(_controller.purchaseBills[index]),
                                  child: PurchaseItemWidget(
                                    purchaseBill:
                                        _controller.purchaseBills[index],
                                    onDeleteClicked: () => _controller.onItemDeleteClicked(_controller.purchaseBills[index]),
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
                    child: Center(child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
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
