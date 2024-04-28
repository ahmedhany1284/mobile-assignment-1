import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_assignment_1/core/local/local_storage.dart';
import 'package:mobile_assignment_1/core/models/user_info/user_info.dart';
import 'package:mobile_assignment_1/core/networking/api_service.dart';
import 'package:mobile_assignment_1/core/networking/urls.dart';
import 'package:mobile_assignment_1/core/utils/cacheHelper.dart';
import 'package:mobile_assignment_1/core/utils/constatns.dart';
import 'package:mobile_assignment_1/features/home/cubit/home_states.dart';
import 'package:path_provider/path_provider.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController =
      TextEditingController();
  TextEditingController genderController =
      TextEditingController();
  TextEditingController emailController =
      TextEditingController();
  TextEditingController sudentIDController =
      TextEditingController();
  TextEditingController levelController = TextEditingController(
     );
  String? profilePictureUrl;

  File? profileImage;
  bool isSelectImage=false;
  init() async {
    await getData();
    nameController.text = AppConst.userProfile!.name!;
    genderController.text = AppConst.userProfile!.gender!;
    emailController.text =  AppConst.userProfile!.email!;
    sudentIDController.text = AppConst.userProfile!.studentId!;
    levelController.text = AppConst.userProfile!.level.toString();



  }


  getData() async {
    emit(HomeLoadingState());
    try {

      var result = await ApiService().get(path: Urls.getData, token: AppConst.token);
      AppConst.userProfile = UserProfile.fromJson(json.decode(result.body)['userData']);
      print('--> here  -> ${AppConst.userProfile!.toJson().toString()}');


      emit(HomeGetUserProfileSuccessState());
    } catch (e) {
      emit(HomeGetUserProfileErrorState(e.toString()));
    }
  }

  Future<void> logout() async {
    AppConst.token = '';
    await CacheHelper.removeData(key: 'token');
    await CacheHelper.removeData(key: 'userProfile');
    emit(HomeLogoutState());
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isSelectImage=true;
      profileImage = File(pickedFile.path);
    }
    emit(HomeProfileImagePickedSuccessState(profileImage));
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      isSelectImage=true;
      profileImage = File(pickedFile.path);
    }
    emit(HomeProfileImagePickedSuccessState(profileImage));
  }

  Future<String?> uploadPhotoAndGetDownloadUrl(File file) async {
    try {
      await Firebase.initializeApp();

      Reference storageRef =
          FirebaseStorage.instance.ref().child(Uri.file(file.path).pathSegments.last);

      await storageRef.putFile(file);

      String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading photo: $e');
      return null;
    }
  }

  Future<void> updateUserProfileLocally({
    required UserProfile updatedProfile,
  }) async {
    try {
      await LocalDatabase.updateUser(updatedProfile);

      emit(UserProfileUpdatedLocallyState());
    } catch (e) {
      emit(UserProfileUpdateErrorState(e.toString()));
    }
  }

}
