import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';

final ThemeData wugTheme = buildTheme();

ThemeData buildTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: WugColors.darkBlue, primaryColor: WugColors.greyBlue);
}
