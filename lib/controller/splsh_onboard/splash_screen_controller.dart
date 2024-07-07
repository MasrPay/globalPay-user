import 'dart:async';

import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../language/language_controller.dart';
import '../../routes/routes.dart';
import '../app_settings/app_settings_controller.dart';

final languageController = Get.find<LanguageController>();

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    _goToScreen();
  }

  _goToScreen() async {
    Timer(
      const Duration(seconds: 6),
      () {
        if (!languageController.isLoading) {
          LocalStorages.isLoggedIn()
              ? Get.offAndToNamed(Routes.signInScreen)
              : Get.offAndToNamed(
                  LocalStorages.isOnBoardDone()
                      ? Routes.signInScreen
                      : Get.find<AppSettingsController>()
                              .appSettingsModel
                              .data
                              .appSettings
                              .user
                              .onboardScreen
                              .isEmpty
                          ? Routes.signInScreen
                          : Routes.onboardScreen,
                );
        }
      },
    );
  }
}
