import 'package:flutter/material.dart';
import 'package:mobile_assignment_1/core/themes/app_colors.dart';

class AppTextTheme {
  static const kDefaultPadding = EdgeInsets.symmetric(horizontal: 20);

  static TextStyle titleText = TextStyle(
    color: AppColors.label,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static TextStyle subTitle = TextStyle(
    color: AppColors.label,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle textButton = TextStyle(
    color: AppColors.label,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleStyle = TextStyle(
    color: AppColors.label,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Arial',
  );
}

extension TextStyleExt on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);

  TextStyle lightBold() => copyWith(fontWeight: FontWeight.w700);

  TextStyle comfort() => copyWith(height: 1.8);

  TextStyle dense() => copyWith(height: 1.2);

}
