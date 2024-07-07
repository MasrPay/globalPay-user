import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:masrpay/utils/dimensions.dart';

class CustomLoadingAPI extends StatelessWidget {
  const CustomLoadingAPI({
    super.key,
    this.colors,
  });
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDualRing(
        color: colors ?? Theme.of(context).primaryColor,
        size: Dimensions.heightSize * 2.6,
      ),
    );
  }
}
