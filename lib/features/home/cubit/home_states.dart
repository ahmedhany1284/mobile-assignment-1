

import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable{
  @override
  List<Object?> get props => [];
}
class HomeInitialState extends HomeStates{}
class HomeLogoutState extends HomeStates{}
class HomeProfileImagePickedSuccessState extends HomeStates{
  final profileImage;
  HomeProfileImagePickedSuccessState(this.profileImage);
  @override
  List<Object?> get props => [profileImage];
}
class UserProfileUpdatedLocallyState extends HomeStates{}
class UserProfileUpdateErrorState extends HomeStates{
  final String error;

  UserProfileUpdateErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
class HomeLoadingState extends HomeStates{}
class HomeGetUserProfileSuccessState extends HomeStates{}

class HomeGetUserProfileErrorState extends HomeStates{
  final String error;

  HomeGetUserProfileErrorState(this.error);
  @override
  List<Object?> get props => [error];
}