import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

Text myTextWidget(label, size, FontWeight weight, [textColor = Colors.black]) {
  return (Text(
    label,
    style: TextStyle(fontSize: size, color: textColor, fontWeight: weight),
  ));
}

Container myTextField(
  label,
  backgroundColor, [
  lines = 1,
]) {
  return Container(
    decoration: BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(15)),
    child: (TextField(
      maxLines: lines,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          labelText: label,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w200, color: Colors.black, ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: CustomColors().HighlightColor),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
    )),
  );
}
