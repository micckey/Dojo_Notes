import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Text myTextWidget(label, size, FontWeight weight, [textColor = Colors.black]) {
  return (Text(
    label,
    style: TextStyle(fontSize: size, color: textColor, fontWeight: weight),
  ));
}

Container myTextField(
  controller,
  label,
  backgroundColor, [
  lines = 1,
]) {
  return Container(
    decoration: BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(15)),
    child: (TextField(
      style: TextStyle(color: CustomColors().darkContentText),
      maxLines: lines,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w200,
            color: CustomColors().darkInfoText,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: CustomColors().highlightColor),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
    )),
  );
}

Container myPasswordField(
  controller,
  label,
  obscure,
  obscureFunc,
  backgroundColor,
) {
  return Container(
    decoration: BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(15)),
    child: (TextField(
      style: TextStyle(color: CustomColors().darkContentText),
      controller: controller,
      obscureText: obscure,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          suffixIcon: obscure == true
              ? GestureDetector(
                  onTap: obscureFunc,
                  child: const Icon(CupertinoIcons.eye_slash))
              : GestureDetector(
                  onTap: obscureFunc, child: const Icon(CupertinoIcons.eye)),
          suffixIconColor: CustomColors().darkTitleText,
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w200,
            color: CustomColors().darkInfoText,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: CustomColors().highlightColor),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
    )),
  );
}

SizedBox kataButton(label) {
  return SizedBox(
    width: 350,
    height: 60,
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(CustomColors().cardColor),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))))),
      child: myTextWidget(
          label, 25.0, FontWeight.normal, CustomColors().whiteTitleText),
    ),
  );
}

Container roundButtons(containerSize, IconData icon, buttonFunction) {
  return Container(
    width: containerSize,
    height: containerSize,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: CustomColors().buttonColor,
    ),
    child: IconButton(
        onPressed: buttonFunction,
        icon: Icon(
          icon,
          size: 40,
          color: CustomColors().whiteContentText,
        )),
  );
}

SizedBox selectedKataWidget(label) {
  return SizedBox(
    width: 115,
    height: 50,
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(CustomColors().buttonColor),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))))),
      child: myTextWidget(label, 18.0, FontWeight.bold),
    ),
  );
}

ElevatedButton dashboardElevatedButton(label, getFunction) {
  return ElevatedButton(
      onPressed: getFunction,
      style: ButtonStyle(
          foregroundColor:
              WidgetStatePropertyAll(CustomColors().darkContentText),
          backgroundColor: WidgetStatePropertyAll(CustomColors().buttonColor),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r)))),
      child: Text(
        label,
        style: TextStyle(fontSize: 20.sp, color: CustomColors().whiteTitleText),
      ));
}

Padding dashboardNoteCardContent(
  name,
  value,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myTextWidget(
            name, 15.sp, FontWeight.w300, CustomColors().whiteTitleText),
        Flexible(
            child: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: CustomColors().whiteContentText),
        )
            // myTextWidget(
            //     value, 20.sp, FontWeight.w500, CustomColors().LightText)
            ),
      ],
    ),
  );
}

Container myEditField(
  controller,
) {
  return Container(
    decoration: BoxDecoration(
        color: CustomColors().highlightColor,
        borderRadius: BorderRadius.circular(15)),
    child: (TextField(
      style: TextStyle(color: CustomColors().darkContentText),
      maxLines: 5,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: CustomColors().highlightColor),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
    )),
  );
}

ElevatedButton dialogButton({buttonFunction, color, label}) {
  return ElevatedButton(
      onPressed: buttonFunction,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
      child: myTextWidget(label, 15.sp, FontWeight.w400));
}

buildSnackBar(title, message, [duration = 2]) {
  Get.snackbar(title, message,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      colorText: CustomColors().whiteContentText,
      snackPosition: SnackPosition.TOP,
      animationDuration: Duration(seconds: duration),
      backgroundColor: title.toString().toLowerCase().contains('fail') ||
              title.toString().toLowerCase().contains('error')
          ? CustomColors().alertText
          : CustomColors().successText);
}
