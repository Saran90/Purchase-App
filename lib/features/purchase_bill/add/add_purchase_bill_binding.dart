import 'package:get/get.dart';

import 'add_purchase_bill_controller.dart';

class AddPurchaseBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPurchaseBillController());
  }
}
