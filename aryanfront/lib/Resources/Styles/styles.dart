import 'package:flutter/material.dart';
import '../Theme/theme_manager.dart'; // مسیر فایل خودت

class AryanText {

  static TextStyle primaryStyle(ThemeColorsManager colors) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.primary, // اینجا instance member رو میدیم
    );
  }
  static TextStyle listTitleStyle(ThemeColorsManager colors) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.listTitlePrimary, // اینجا instance member رو میدیم
    );
  }
  static TextStyle listContentTitleStyle(ThemeColorsManager colors) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.listContentTitlePrimary, // اینجا instance member رو میدیم
    );
  }
  static TextStyle listContentStyle(ThemeColorsManager colors) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.listContentPrimary, // اینجا instance member رو میدیم
    );
  }
  static TextStyle darkStyle(ThemeColorsManager colors) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.listTitlePrimary, // اینجا instance member رو میدیم
    );
  }
  static TextStyle secondary(ThemeColorsManager colors) {
    return TextStyle(
      fontSize: 16,
      color: colors.secondary,
    );
  }


}
