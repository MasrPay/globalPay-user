import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class BuyGiftCardController extends GetxController {
  void ontapCard() {
    Get.toNamed(Routes.cardDetailsScreen);
  }
   // final CarouselController carouselController = CarouselController();

  RxInt current = 0.obs;
}