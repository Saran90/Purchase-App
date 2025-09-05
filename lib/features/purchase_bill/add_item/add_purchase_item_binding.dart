import 'package:get/get.dart';

import 'add_purchase_item_controller.dart';

class AddPurchaseItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPurchaseItemController());
  }
}
