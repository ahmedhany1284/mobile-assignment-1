

import 'package:mobile_assignment_1/core/models/usermodel/user_model.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final AppUser loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}
class LoginChangePasswordState extends LoginStates{}
