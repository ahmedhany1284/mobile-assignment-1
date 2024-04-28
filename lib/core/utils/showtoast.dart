import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void showToast({
  required String massage,
  required ToastStates state,
}) =>
    Toast.show(
      backgroundColor: chooseToastColor(state)!,
      massage,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      textStyle: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
      ),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}
