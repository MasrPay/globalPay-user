import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globalpay/controller/auth/login/signin_controller.dart';

import '../../../backend/model/auth/login/reset_password.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final controller = Get.put(SignInController());
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  late ResetPasswordModel _resetPasswordModel;

  ResetPasswordModel get resetPasswordModel => _resetPasswordModel;

  // Login process function
  Future<ResetPasswordModel> resetApiProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': Get.arguments['otp'],
      'phone': Get.arguments['phone'],
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    };
    // calling login api from api service
    await ApiServices.resetPasswordApi(body: inputBody).then((value) {
      _resetPasswordModel = value!;
      Get.toNamed(Routes.signInScreen);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _resetPasswordModel;
  }
}
