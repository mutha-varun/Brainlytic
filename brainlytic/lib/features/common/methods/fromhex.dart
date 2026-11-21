import 'package:material_ui/material_ui.dart';

Color hextoColor(String hex) {
      return Color(int.parse(hex, radix: 16) + 0xFF000000);
  }