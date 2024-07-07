import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masrpay/backend/utils/custom_loading_api.dart';
import 'package:masrpay/controller/categories/agent_moneyout/agent_moneyout_controller.dart';
import 'package:masrpay/custom_assets/assets.gen.dart';
import 'package:masrpay/routes/routes.dart';
import 'package:masrpay/utils/custom_color.dart';
import 'package:masrpay/utils/dimensions.dart';
import 'package:masrpay/utils/responsive_layout.dart';
import 'package:masrpay/utils/size.dart';
import 'package:masrpay/widgets/appbar/appbar_widget.dart';
import 'package:masrpay/widgets/buttons/primary_button.dart';

import '../../../language/english.dart';
import '../../../widgets/inputs/agent_input_field_widget.dart';
import '../../../widgets/inputs/agent_money_out_input.dart';
import '../../../widgets/others/limit_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class AgentMoneyOutScreen extends StatelessWidget {
  AgentMoneyOutScreen({super.key});

  final controller = Get.put(AgentMoneyOutController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: const AppBarWidget(text: Strings.agentMoneyOut),
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
                AgentInputFieldWidget(
                  suffixIcon: Assets.icon.scan,
                  suffixColor: CustomColor.whiteColor,
                  onTap: () {
                    Get.toNamed(Routes.qRCodeAgentMoneyOutScreen);
                  },
                  controller: controller.copyInputController,
                  hint: Strings.enterEmailAddress,
                  label: Strings.emailAddress,
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
            AgentMoneyOutInputWithDropdown(
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
                    Get.toNamed(Routes.agentMoneyScreenPreviewScreen);
                  }
                },
              ),
      ),
    );
  }
}
