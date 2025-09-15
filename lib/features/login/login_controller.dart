import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purchase_app/api/auth/auth_api.dart';
import 'package:purchase_app/api/auth/models/login_request.dart';
import 'package:purchase_app/main.dart';
import 'package:purchase_app/utils/routes.dart';

import '../../api/error_response.dart';
import '../../data/app_storage_keys.dart';
import '../../data/error/failures.dart';
import '../../utils/messages.dart';
import '../../utils/utility_functions.dart';

class LoginController extends GetxController {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthApi authApi = Get.find();
  RxBool isLoading = RxBool(false);

  Future<void> onLoginClicked() async {
    if (_validateFields()) {
      isLoading.value = true;
      var result = await authApi.login(
        LoginRequest(
          username: userNameController.text,
          password: passwordController.text,
        ),
      );
      result.fold(
        (l) {
          if (l is APIFailure) {
            ErrorResponse? errorResponse = l.error;
            showToast(message: errorResponse?.message ?? apiFailureMessage);
          } else if (l is ServerFailure) {
            showToast(message: l.message ?? serverFailureMessage);
          } else if (l is NetworkFailure) {
            showToast(message: networkFailureMessage);
          } else {
            showToast(message: unknownFailureMessage);
          }
          isLoading.value = false;
        },
        (r) async {
          if (r?.token != null) {
            await appStorage.setToken(
              accessToken: r!.token!,
              refreshToken: ''
            );
            Get.offAndToNamed(purchaseBillsRoute);
          } else {
            showToast(message: loginFailedMessage);
          }
          isLoading.value = false;
        },
      );
    }
  }

  bool _validateFields() {
    if (userNameController.text.isEmpty) {
      showToast(message: enterUsernameMessage);
      return false;
    } else if (passwordController.text.isEmpty) {
      showToast(message: enterPasswordMessage);
      return false;
    } else {
      return true;
    }
  }
}
