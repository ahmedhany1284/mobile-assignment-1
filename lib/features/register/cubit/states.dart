

import 'package:equatable/equatable.dart';

abstract class RegisterStates extends Equatable{
  @override
  List<Object?> get props => [];
}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{}
class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class CreateUserSuccessState extends RegisterStates{}
class CreateUserErrorState extends RegisterStates
{
  final String error;

  CreateUserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class RegisterChangePasswordState extends RegisterStates{}
class RegisterUserStoredLocallyState extends RegisterStates{}
class RegisterUserStorageErrorState extends RegisterStates{
  final String error;

  RegisterUserStorageErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


