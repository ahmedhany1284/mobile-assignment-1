import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assignment_1/core/models/user_info/user_info.dart';
import 'package:mobile_assignment_1/core/models/usermodel/user_model.dart';
import 'package:mobile_assignment_1/core/networking/api_service.dart';
import 'package:mobile_assignment_1/core/networking/urls.dart';
import 'package:mobile_assignment_1/core/utils/cacheHelper.dart';
import 'package:mobile_assignment_1/core/utils/constatns.dart';
import 'package:mobile_assignment_1/features/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  AppUser? loginmodel;

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      var response = await ApiService().post(
        path: Urls.login,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        loginmodel = AppUser.fromJson(value['userData']);
        print(loginmodel!.toJson().toString());
        AppConst.token = value['token'];

        AppConst.userProfile = UserProfile(
          name: loginmodel!.name,
          gender: loginmodel!.gender,
          email: loginmodel!.email,
          studentId: loginmodel!.studentId,
          level: loginmodel!.level??0,
          profilePhoto: loginmodel!.profilePhoto,
        );
        try {
        } catch (e) {
          print('Error saving data: $e');
        }
        emit(LoginSuccessState(loginmodel!));
      } else {
        emit(LoginErrorState(
            'Failed to login. Status code: ${response.statusCode}'));
      }
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void change_pass_visibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePasswordState());
  }
}
