// ignore_for_file: unnecessary_to_list_in_spreads
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masrpay/backend/services/notification_service.dart';
import 'package:masrpay/backend/utils/custom_loading_api.dart';
import 'package:masrpay/utils/dimensions.dart';
import 'package:masrpay/utils/responsive_layout.dart';
import 'package:masrpay/widgets/appbar/back_button.dart';
import 'package:masrpay/widgets/buttons/primary_button.dart';
import 'package:masrpay/widgets/inputs/password_input_widget.dart';
import 'package:masrpay/widgets/inputs/phone_number_with_contry_code_input.dart';
import 'package:masrpay/widgets/inputs/primary_input_filed.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controller/auth/registration/kyc_form_controller.dart';
import '../../../controller/auth/registration/otp_email_controoler.dart';
import '../../../controller/auth/registration/registration_controller.dart';
import '../../../language/english.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/size.dart';
import '../../../widgets/inputs/country_with_country_code_input_widget.dart';
import '../../../widgets/text_labels/title_heading2_widget.dart';
import '../../../widgets/text_labels/title_heading4_widget.dart';

class KycFromScreen extends StatefulWidget {
  final String phoneNum;

  KycFromScreen({Key? key, required this.phoneNum}) : super(key: key);

  @override
  _KycFromScreenState createState() => _KycFromScreenState();
}

class _KycFromScreenState extends State<KycFromScreen> {
  final emailController = Get.put(EmailOtpController());
  final registrationController = Get.put(RegistrationController());
  final kycController = Get.put(BasicDataController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the tree
    emailController.dispose();
    registrationController.dispose();
    kycController.dispose();

    super.dispose();  // Always call super.dispose() at the end
  }

  @override
  Widget build(BuildContext context) {
    // Ensure phoneNum is passed correctly
    if (widget.phoneNum.isEmpty) {
      return Scaffold(
        body: Center(child: Text('Phone number is missing')),
      );
    }

    // Initialize phoneNum in the controller if it's not already initialized
    if (kycController.phoneNum == null || kycController.phoneNum!.isEmpty) {
      kycController.phoneNum = widget.phoneNum;
    }

    return ResponsiveLayout(
      mobileScaffold: PopScope(
        canPop: true,
        onPopInvoked: (value) async {
          if (!value) {
            Get.offAllNamed(Routes.registrationScreen);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: BackButtonWidget(
              onTap: () {
                Get.offAllNamed(Routes.registrationScreen);
              },
            ),
          ),
          body: Obx(
                () => kycController.isLoading
                ? const CustomLoadingAPI()
                : _bodyWidget(context),
          ),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
      physics: const BouncingScrollPhysics(),
      children: [
        _titleAndSubtitleWidget(context),
        _inputWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _titleAndSubtitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical,
        bottom: Dimensions.marginSizeVertical * 1.4,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TitleHeading2Widget(text: Strings.register.tr),
          verticalSpace(Dimensions.heightSize * 0.7),
          TitleHeading4Widget(text: Strings.registerDetails.tr),
        ],
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            children: [
              Expanded(
                child: PrimaryInputWidget(
                  hint: Strings.enterFirstName.tr,
                  label: Strings.firstName.tr,
                  controller: kycController.firstNameController,
                ),
              ),
              horizontalSpace(Dimensions.widthSize),
              Expanded(
                child: PrimaryInputWidget(
                  hint: Strings.enterLastName.tr,
                  label: Strings.lastName.tr,
                  controller: kycController.lastNameController,
                ),
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize),
          PhoneNumberInputWidget(
            readOnly: true,
            initVal: widget.phoneNum,
            countryCode: '02'.obs, // New fixed country code
            hint: Strings.xxx.tr,
            label: Strings.phoneNumber.tr,
            keyBoardType: TextInputType.number,
          ),
          verticalSpace(Dimensions.heightSize * 0.6),
          Row(
            children: [
              Expanded(
                child: PrimaryInputWidget(
                  hint: Strings.enterCity.tr,
                  label: Strings.city.tr,
                  controller: kycController.cityController,
                ),
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize),
          PasswordInputWidget(
            keyBoardType: TextInputType.number,
            maxLength: 6,
            controller: kycController.passwordController,
            hint: Strings.enterPassword.tr,
            label: Strings.newPassword.tr,
          ),
          verticalSpace(Dimensions.heightSize),
          PasswordInputWidget(
            keyBoardType: TextInputType.number,
            maxLength: 6,
            controller: kycController.confirmPasswordController,
            hint: Strings.enterConfirmPassword.tr,
            label: Strings.confirmPassword.tr,
          ),
          FittedBox(
            child: Row(
              children: [
                Obx(
                      () => SizedBox(
                    width: 20,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius * 0.3),
                      ),
                      fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      value: kycController.termsAndCondition.value,
                      onChanged: kycController.termsAndCondition.call,
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                          width: 1.4,
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    const url = 'https://stgapp.masrpay.com/page/terms-and-conditions';
                    if (await canLaunch(url)) {
                      await launch(url, forceWebView: true, enableJavaScript: true);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: TitleHeading4Widget(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.headingTextSize5,
                    fontWeight: FontWeight.w500,
                    text: Strings.agreed.tr,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 1.4),
      child: Obx(
            () => kycController.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
          title: Strings.continuee.tr,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              kycController.registrationProcess();
            }
          },
        ),
      ),
    );
  }
}

