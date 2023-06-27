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
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w200,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: CustomColors().HighlightColor),
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
          backgroundColor: MaterialStatePropertyAll(CustomColors().CardColor),
          shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))))),
      child: myTextWidget(label, 25.0, FontWeight.normal),
    ),
  );
}

Container roundButtons(containerSize, IconData icon) {
  return Container(
    width: containerSize,
    height: containerSize,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: CustomColors().ButtonColor,
    ),
    child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          size: 40,
        )),
  );
}

SizedBox kataCategoryButton(label) {
  return SizedBox(
    width: 115,
    height: 50,
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(CustomColors().ButtonColor),
          shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))))),
      child: myTextWidget(label, 18.0, FontWeight.bold),
    ),
  );
}
