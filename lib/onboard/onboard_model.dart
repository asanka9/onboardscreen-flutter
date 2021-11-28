import 'package:flutter/cupertino.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color smBtnBg;
  Color text1Color;
  Color text2Color;
  Color btnBg;
  Color nextColor;
  Color skipColor;

  OnboardModel(
      {required this.img,
      required this.text,
      required this.desc,
      required this.bg,
      required this.smBtnBg,
      required this.btnBg,
      required this.nextColor,
      required this.skipColor,
      required this.text1Color,
      required this.text2Color});
}
