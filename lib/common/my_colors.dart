import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class MyColors {
  static Color main = HexColor('#EEF5DB');
  static Color drawerTheme = HexColor('FF7D27');
  static Color textTheme = HexColor('E8EEF2');
  static Color darkTextTheme = HexColor('37393A');
  static Color colorBlue = HexColor('77B6EA');
  static Color colorBlack = Colors.black;
}
