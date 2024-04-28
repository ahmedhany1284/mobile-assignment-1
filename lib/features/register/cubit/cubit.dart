import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assignment_1/core/local/local_storage.dart';
import 'package:mobile_assignment_1/core/models/usermodel/user_model.dart';
import 'package:mobile_assignment_1/core/networking/api_service.dart';
import 'package:mobile_assignment_1/core/networking/urls.dart';
import 'package:mobile_assignment_1/features/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String studentId,
    required String gender,
    required int level,

  }) {
    emit(RegisterLoadingState());
    AppUser model = AppUser(
      name: name ,
      email: email,
      password: password,
      studentId: studentId,
      gender: gender,
      level: level,
    );
    try {
      ApiService().post(
        path: Urls.register,
        body: model.toJson(),
      );

    }catch(error) {
      emit(RegisterErrorState(error.toString()));
    };
  }


  Future<void> storeUserLocally({
    required String name,
    required String email,
    required String password,
    required String studentId,
    required String gender,
    required int level,
  }) async {
    try {
      AppUser model = AppUser(
        name: name,
        email: email,
        password: password,
        studentId: studentId,
        gender: gender,
        level: level,
      );

      await LocalDatabase.insertUser(model);
      emit(RegisterUserStoredLocallyState());
    } catch (e) {

      emit(RegisterUserStorageErrorState( e.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void change_pass_visibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordState());
  }
}
