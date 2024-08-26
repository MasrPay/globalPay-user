// ignore_for_file: unnecessary_to_list_in_spreads
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masrpay/backend/utils/custom_loading_api.dart';
import 'package:masrpay/utils/dimensions.dart';
import 'package:masrpay/utils/responsive_layout.dart';
import 'package:masrpay/widgets/appbar/back_button.dart';
import 'package:masrpay/widgets/buttons/primary_button.dart';
import 'package:masrpay/widgets/inputs/password_input_widget.dart';
import 'package:masrpay/widgets/inputs/phone_number_with_contry_code_input.dart';
import 'package:masrpay/widgets/inputs/primary_input_filed.dart';
import '../../../controller/auth/registration/kyc_form_controller.dart';
import '../../../controller/auth/registration/otp_email_controoler.dart';
import '../../../controller/auth/registration/registration_controller.dart';
import '../../../language/english.dart';
import '../../../routes/routes.dart';
import '../../../utils/size.dart';
import '../../../widgets/text_labels/title_heading2_widget.dart';
import '../../../widgets/text_labels/title_heading4_widget.dart';
class KycFromScreen extends StatelessWidget {
  KycFromScreen({super.key,required this.phoneNum});
  final String phoneNum;
  final emailController = Get.put(EmailOtpController());
  final registrationController = Get.put(RegistrationController());
  final kycController = Get.put(BasicDataController());
  final _forkKey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
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
      key: _forkKey,
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
          // PrimaryInputWidget(
          //   readOnly: true,
          //   controller: registrationController.emailController,
          //   hint: Strings.enterEmailAddress.tr,
          //   label: Strings.emailAddress.tr,
          //   keyboardType: TextInputType.emailAddress,
          // ),
          // verticalSpace(Dimensions.heightSize),
          ///---------------Country Comm
          /* CountryInputWidget(
            countryCode: kycController.countryCode,
            readOnly: true,
            controller: kycController.countryController,
            hint: Strings.country.tr,
            label: Strings.country.tr,
          ),*/
          verticalSpace(Dimensions.heightSize * 0.6),
          PhoneNumberInputWidget(
            readOnly: true,
            initVal: phoneNum,
            // countryCode: kycController.countryCode,///old
            countryCode: '+2'.obs, ///New
            // controller: kycController.phoneNumberController,///old
            hint: Strings.xxx.tr,
            label: Strings.phoneNumber.tr,
            keyBoardType: TextInputType.number,
          ),
          verticalSpace(Dimensions.heightSize * 0.6),
          //!row widget
          Row(
            children: [
              Expanded(
                child: PrimaryInputWidget(
                  hint: Strings.enterCity.tr,
                  label: Strings.city.tr,
                  controller: kycController.cityController,
                ),
              ),
              horizontalSpace(Dimensions.widthSize),
              ///------ZIP CODE Comment
              // Expanded(
              //   child: PrimaryInputWidget(
              //     keyboardType: TextInputType.text,
              //     hint: Strings.enterZipCode.tr,
              //     label: Strings.zipCode.tr,
              //     controller: kycController.zipCodeController,
              //   ),
              // ),
            ],
          ),

          Visibility(
            visible: kycController.inputFileFields.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.marginSizeVertical * 0.5,
              ),
              height: kycController.inputFileFields.length == 2
                  ? MediaQuery.of(context).size.height * 0.20
                  : MediaQuery.of(context).size.height * 0.25,
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                  ),
                  itemCount: kycController.inputFileFields.length,
                  // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    return kycController.inputFileFields[index];
                  }),
            ),
          ),
          Obx(() {
            return Column(
              children: [
                ...kycController.inputFields.map((element) {
                  return element;
                }).toList(),
                verticalSpace(Dimensions.heightSize * 0.5),
              ],
            );
          }),

          horizontalSpace(Dimensions.widthSize),

          //! password input widgets
          ///--------------OLD -------------------------
          PasswordInputWidget(
            keyBoardType: TextInputType.number,
            maxLength: 6,
            controller: kycController.passwordController,
            hint: Strings.enterPassword.tr,
            label: Strings.newPassword.tr,
          ),
          // TitleHeading4Widget(
          //   text: Strings.newPassword.tr,
          //   fontWeight: FontWeight.w600,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: Dimensions.heightSize * 2,
          //   ),
          //   child: PinCodeTextField(
          //     errorTextSpace: Dimensions.heightSize * 2,
          //     cursorColor: Theme.of(context).primaryColor,
          //     controller:  kycController.passwordController,
          //     appContext: context,
          //     length: 6,
          //     obscureText: false,
          //     keyboardType: TextInputType.number,
          //     textStyle: TextStyle(color: Theme.of(context).primaryColor),
          //     animationType: AnimationType.fade,
          //     validator: (v) {
          //       if (v!.length < 6) {
          //         return Strings.pleaseFillOutTheField.translation;
          //       } else {
          //         return null;
          //       }
          //     },
          //     pinTheme: PinTheme(
          //         shape: PinCodeFieldShape.box,
          //         borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
          //         selectedColor: Theme.of(context).primaryColor,
          //         activeColor: Theme.of(context).primaryColor,
          //         inactiveColor: CustomColor.blackColor,
          //         fieldHeight: 50,
          //         fieldWidth: 48,
          //         errorBorderColor: CustomColor.redColor,
          //         activeFillColor: CustomColor.transparent,
          //         borderWidth: 2,
          //         fieldOuterPadding: const EdgeInsets.all(1)),
          //     onChanged: (value) {
          //       kycController.changeCurrentText(value);
          //     },
          //   ),
          // ),
          verticalSpace(Dimensions.heightSize),
          PasswordInputWidget(
            keyBoardType: TextInputType.number,
            maxLength: 6,
            controller: kycController.confirmPasswordController,
            hint: Strings.enterConfirmPassword.tr,
            label: Strings.confirmPassword.tr,
          ),
          /* TitleHeading4Widget(
            text: Strings.confirmPassword.tr,
            fontWeight: FontWeight.w600,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.heightSize * 2,
            ),
            child: PinCodeTextField(
              errorTextSpace: Dimensions.heightSize * 1,
              cursorColor: Theme.of(context).primaryColor,
              controller:  kycController.confirmPasswordController,
              appContext: context,
              length: 6,
              obscureText: false,
              keyboardType: TextInputType.number,
              textStyle: TextStyle(color: Theme.of(context).primaryColor),
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 6) {
                  return Strings.pleaseFillOutTheField.translation;
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
                  selectedColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: CustomColor.blackColor,
                  fieldHeight: 50,
                  fieldWidth: 48,
                  errorBorderColor: CustomColor.redColor,
                  activeFillColor: CustomColor.transparent,
                  borderWidth: 2,
                  fieldOuterPadding: const EdgeInsets.all(1)),
              onChanged: (value) {
                kycController.changeCurrentText(value);
              },
            ),
          ),
*/
          FittedBox(
            child: Row(
              children: [
                Obx(
                      () => SizedBox(
                    width: 20,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.3),
                      ),
                      fillColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      value: kycController.termsAndCondition.value,
                      onChanged: kycController.termsAndCondition.call,
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                          width: 1.4,
                          color:
                          Theme.of(context).primaryColor.withOpacity(0.2),
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
          )
        ],
      ),
    );
  }
  _buttonWidget(BuildContext context) {
    return Container(
      margin:
      EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 1.4),
      child: Obx(
            () => kycController.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
          title: Strings.continuee.tr,
          onPressed: (){
            if (_forkKey.currentState!.validate()){
              kycController.phoneNum = phoneNum;
              kycController.registrationProcess();

            }
          },
        ),
      ),
    );
  }

}

