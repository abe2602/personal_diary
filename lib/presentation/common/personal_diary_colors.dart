import 'package:flutter/material.dart';

mixin PersonalDiaryColors {
  static final Map<int, Color> _primaryColorSwatch = {
    50: vividPastelPurple.withOpacity(.1),
    100: vividPastelPurple.withOpacity(.2),
    200: vividPastelPurple.withOpacity(.3),
    300: vividPastelPurple.withOpacity(.4),
    400: vividPastelPurple.withOpacity(.5),
    500: vividPastelPurple.withOpacity(.6),
    600: vividPastelPurple.withOpacity(.7),
    700: vividPastelPurple.withOpacity(.8),
    800: vividPastelPurple.withOpacity(.9),
    900: vividPastelPurple.withOpacity(1)
  };

  static Color primaryColor = MaterialColor(
    vividPastelPurple.value,
    _primaryColorSwatch,
  );

  static const Color lightBackground = Color(0xFFF1F6F7);

  static const Color vividPastelPurple = Color(0xFFA262FF);

  static const Color pastelPurple = Color(0xFFDAC1FF);

  static const Color pastelSalmon = Color(0xFFfff9f4);

  static const Color darkBackground = Color(0xFF0B0B0B);

  static const Color blackChocos = Color(0xFF090909);

  static const Color cream = Color(0xFFF4F8F9);

  static const Color iconColor = Color(0xFF666666);

  static const Color divisorColor = Color(0xFFD2D2D2);

  static const Color primaryTextColor = Color(0xFF424242);

  static const Color secondaryTextColor = Color(0xFF888888);

  static const Color gray = Color(0xFF888888);
}
