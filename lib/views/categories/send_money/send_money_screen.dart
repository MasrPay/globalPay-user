import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globalpay/backend/utils/custom_loading_api.dart';
import 'package:globalpay/custom_assets/assets.gen.dart';
import 'package:globalpay/routes/routes.dart';
import 'package:globalpay/utils/custom_color.dart';
import 'package:globalpay/utils/dimensions.dart';
import 'package:globalpay/utils/responsive_layout.dart';
import 'package:globalpay/utils/size.dart';
import 'package:globalpay/widgets/appbar/appbar_widget.dart';
import 'package:globalpay/widgets/buttons/primary_button.dart';
import 'package:globalpay/widgets/inputs/input_with_dropdown.dart';

import '../../../controller/categories/send_money/send_money_controller.dart';
import '../../../language/english.dart';
import '../../../widgets/inputs/copy_with_input.dart';
import '../../../widgets/others/limit_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class MoneyTransferScreen extends StatelessWidget {
  MoneyTransferScreen({super.key});

  final controller = Get.put(SendMoneyController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: const AppBarWidget(text: Strings.sendMoney),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.9),
      physics: const BouncingScrollPhysics(),
      children: [
        _inputWidget(context),
        Obx(() {
          return LimitWidget(
              fee:
                  '${controller.totalFee.value.toStringAsFixed(4)} ${controller.baseCurrency.value}',
              limit:
                  '${controller.limitMin} - ${controller.limitMax} ${controller.baseCurrency.value}');
        }),
        _buttonWidget(context),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * 1.6),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CopyInputWidget(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  suffixIcon: Assets.icon.scan,
                  suffixColor: CustomColor.whiteColor,
                  onTap: () {
                    Get.toNamed(Routes.qRCodeScreen);
                  },
                  controller: controller.copyInputController,
                  hint: Strings.enterPhoneNumber,
                  label: Strings.phoneNumber,
                ),
                Obx(() {
                  return TitleHeading5Widget(
                    text: controller.checkUserMessage.value,
                    color: controller.isValidUser.value
                        ? CustomColor.greenColor
                        : CustomColor.redColor,
                  );
                })
              ],
            ),
            verticalSpace(Dimensions.heightSize),
            SendMoneyInputWithDropdown(
              controller: controller.amountController,
              hint: Strings.zero00,
              label: Strings.amount,
            ),
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 4,
        bottom: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controller.isSendMoneyLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.send,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Get.toNamed(Routes.sendMoneyPreviewScreen);
                  }
                },
              ),
      ),
    );
  }
}
