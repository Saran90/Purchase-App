import 'package:get/get.dart';
import 'package:purchase_app/features/purchase_bill/list/purchase_bills_controller.dart';

class PurchaseBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseBillsController());
  }
}
