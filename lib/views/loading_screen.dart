import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../configurations/style.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors().backgroundColor,
      child: Center(
        child: LoadingAnimationWidget.beat(
            color: CustomColors().darkTitleText, size: 100.r),
      ),
    );
  }
}
