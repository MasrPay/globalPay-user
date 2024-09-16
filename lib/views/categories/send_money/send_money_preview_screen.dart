import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globalpay/backend/utils/custom_loading_api.dart';
import 'package:globalpay/utils/dimensions.dart';
import 'package:globalpay/utils/responsive_layout.dart';
import 'package:globalpay/widgets/appbar/appbar_widget.dart';
import 'package:globalpay/widgets/buttons/primary_button.dart';
import 'package:globalpay/widgets/others/preview/amount_preview_widget.dart';
import 'package:globalpay/widgets/others/preview/information_amount_widget.dart';

import '../../../backend/services/notification_service.dart';
import '../../../controller/categories/send_money/send_money_controller.dart';
import '../../../language/english.dart';
import '../../../routes/routes.dart';
import '../../../widgets/others/congratulation_widget.dart';

class SendMoneyPreviewScreen extends StatelessWidget {
  SendMoneyPreviewScreen({super.key});

  final controller = Get.put(SendMoneyController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: const AppBarWidget(text: Strings.preview),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      physics: const BouncingScrollPhysics(),
      children: [
        _amountWidget(context),
        _amountInformationWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _amountWidget(BuildContext context) {
    return previewAmount(
        amount:
            '${controller.amountController.text} ${controller.baseCurrency.value}');
  }

  _amountInformationWidget(BuildContext context) {
    return amountInformationWidget(
      information: Strings.amountInformation,
      enterAmount: Strings.enterAmount,
      enterAmountRow:
          '${controller.amountController.text} ${controller.baseCurrency.value}',
      fee: Strings.transferFee,
      feeRow:
          '${controller.totalFee.value.toStringAsFixed(2)} ${controller.baseCurrency.value}',
      received: Strings.recipientReceived,
      receivedRow:
          '${controller.amountController.text} ${controller.baseCurrency.value}',
      total: Strings.totalPayable,
      totalRow:
          '${(double.parse(controller.amountController.text.isNotEmpty ? controller.amountController.text : '0.0') + controller.totalFee.value)} ${controller.baseCurrency.value}',
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 2,
      ),
      child: Obx(
        () => controller.isSendMoneyLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  controller.sendMoneyProcess(context).then(
                        (value) => StatusScreen.show(
                          context: context,
                          subTitle: Strings.yourmoneySenSuccess.tr,
                          onPressed: () {
                            Get.offAllNamed(Routes.bottomNavBarScreen);
                            NotificationService.showLocalNotification(
                              title: 'Success',
                              body: Strings.yourmoneySenSuccess,
                            );
                          },
                        ),
                      );
                },
              ),
      ),
    );
  }
}
