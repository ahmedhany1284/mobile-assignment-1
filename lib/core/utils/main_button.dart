import 'package:flutter/material.dart';
import 'package:mobile_assignment_1/core/themes/app_colors.dart';
import 'package:mobile_assignment_1/core/themes/themes.dart';



class MainBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const MainBtn({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primary),
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 50),
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      child: Text(
        title,
        style: AppTextTheme.textButton.copyWith(
          color: AppColors.background,
        ),
      ),
    );
  }
}
