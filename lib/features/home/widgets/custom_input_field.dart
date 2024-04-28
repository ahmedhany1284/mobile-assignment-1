
import 'package:flutter/material.dart';
import 'package:mobile_assignment_1/core/themes/app_colors.dart';
import 'package:mobile_assignment_1/core/themes/themes.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.type,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.readOnly = false,
    required this.validate,
    required this.label,
    required this.icon,
    this.suffix,
    this.suffixPressed,
  });

  final TextEditingController controller;
  final TextInputType type;
  final Function? onChange;
  final Function? onSubmit;
  final Function? onTap;
  final String? Function(String?)? validate;
  final String label;
  final bool readOnly;
  final IconData icon;
  final IconData? suffix;
  final VoidCallback? suffixPressed;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final bool isPassword = false;

  final bool clickable = true;

  final double borderRadius = 20;
  bool isFocus = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          isFocus = focus;
        });
      },
      child: SizedBox(
        height: isError ? 90 : 60,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.type,
          obscureText: isPassword,
          readOnly: widget.readOnly,
          onFieldSubmitted: widget.onSubmit as void Function(String)?,
          onChanged: widget.onChange as void Function(String)?,
          onTap: widget.onTap as void Function()?,
          validator: (val) {
            if (widget.validate != null) {
              final error = widget.validate!(val);
              setState(() {
                isError = error != null;
              });
              return error;
            }
            return null;
          },
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          cursorHeight: 25,
          decoration: InputDecoration(
            labelText: widget.label,
            contentPadding: const EdgeInsets.only(top: 35, left: 20),
            labelStyle: AppTextTheme.subTitle.copyWith(
              fontSize: (isFocus == true) ? 20 : 18,
            ),
            prefixIcon: Icon(widget.icon, color: AppColors.label),
            suffixIcon: widget.suffix != null
                ? IconButton(
              onPressed: widget.suffixPressed,
              icon: Icon(widget.suffix, color: AppColors.label),
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 5.0,
                color: AppColors.secondary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 5.0,
                color: AppColors.secondary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1.0,
                color: AppColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1.0,
                color: AppColors.error,
              ),
            ),
            filled: true,
            fillColor: (isFocus || widget.controller.text.isNotEmpty)
                ? AppColors.background
                : AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
