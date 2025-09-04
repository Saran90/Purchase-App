import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purchase_app/utils/routes.dart';

class LoginController extends GetxController {

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void onLoginClicked() {
    Get.offAndToNamed(addPurchaseBillRoute);
  }
}