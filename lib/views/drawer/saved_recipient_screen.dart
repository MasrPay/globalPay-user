import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globalpay/routes/routes.dart';
import 'package:globalpay/utils/custom_color.dart';
import 'package:globalpay/utils/dimensions.dart';
import 'package:globalpay/utils/responsive_layout.dart';
import 'package:globalpay/widgets/appbar/appbar_widget.dart';
import 'package:globalpay/widgets/drawer/save_recipients_widget.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../backend/utils/status_data_widget.dart';
import '../../controller/drawer/all_recipient_controller.dart';
import '../../language/english.dart';

class SaveRecipientScreen extends StatelessWidget {
  SaveRecipientScreen({super.key});

  final controller = Get.put(AllRecipientController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.add,
              color: CustomColor.whiteColor,
              size: 30,
            ),
            onPressed: () {
              Get.toNamed(Routes.addRecipientScreen);
            }),
        appBar: const AppBarWidget(
          text: Strings.savedReceipients,
        ),
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return controller.allRecepientData.data.recipients.isEmpty
        ? InkWell(
            onTap: () {
              Get.toNamed(Routes.addRecipientScreen);
            },
            child: const StatusDataWidget(
              text: "No Recipient Found! Please Add First",
              icon: Icons.person_add_alt,
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.76),
            itemCount: controller.allRecepientData.data.recipients.length,
            itemBuilder: (context, index) {
              var data = controller.allRecepientData.data.recipients[index].obs;
              return SaveRecipientWidget(
                title: "${data.value.firstname} ${data.value.lastname}",
                subTitle: data.value.mobile,
                type: data.value.trxTypeName,
                onTap: (value) {
                  Get.back();
                  if (value == "Remove Recipient") {
                    controller
                        .recipientDeleteApiProcess(id: data.value.id.toString())
                        .then((value) =>
                            Get.offAllNamed(Routes.bottomNavBarScreen));
                  } else if (value == "Edit Recipient") {
                    controller.recipientEditApiProcess(
                        id: data.value.id.toString());
                  } else if (value == "Send") {
                  } else {}
                },
              );
            },
          );
  }
}
