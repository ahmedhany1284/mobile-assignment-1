import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_assignment_1/core/models/user_info/user_info.dart';
import 'package:mobile_assignment_1/core/models/usermodel/user_model.dart';
import 'package:mobile_assignment_1/core/networking/api_service.dart';
import 'package:mobile_assignment_1/core/networking/urls.dart';
import 'package:mobile_assignment_1/core/routes/app_router.dart';
import 'package:mobile_assignment_1/core/utils/cacheHelper.dart';
import 'package:mobile_assignment_1/core/utils/constatns.dart';
import 'package:mobile_assignment_1/core/utils/main_button.dart';
import 'package:mobile_assignment_1/core/utils/validations.dart';
import 'package:mobile_assignment_1/features/home/cubit/home_cubit.dart';
import 'package:mobile_assignment_1/features/home/cubit/home_states.dart';
import 'package:mobile_assignment_1/features/home/widgets/custom_input_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    HomeCubit.get(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                  onPressed: () async {
                    await BlocProvider.of<HomeCubit>(context).logout();
                    context.go(AppRouter.kLoginView);
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: ProfileScreen(),
        );
      },
    );
  }
}

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          if (AppConst.userProfile == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: homeCubit.isSelectImage
                                ? FileImage(homeCubit.profileImage!)
                                    as ImageProvider
                                : AppConst.userProfile!.profilePhoto!.isEmpty ||
                                        AppConst.userProfile!.profilePhoto ==
                                            null
                                    ? const NetworkImage(
                                        'https://image.pngaaa.com/441/1494441-middle.png')
                                    : NetworkImage(
                                        AppConst.userProfile!.profilePhoto!),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Choose an option'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        ListTile(
                                          leading:
                                              const Icon(Icons.photo_library),
                                          title:
                                              const Text('Choose from gallery'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            homeCubit.getImageFromGallery();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.camera_alt),
                                          title: const Text('Take a photo'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            homeCubit.takePhoto();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const CircleAvatar(
                            radius: 15.0,
                            child: Icon(
                              Icons.camera,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Column(
                      children: [
                        CustomInputField(
                          controller: homeCubit.nameController,
                          type: TextInputType.text,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Name',
                            val: value,
                            fieldType: ValidationType.text,
                          ),
                          label: 'Name',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 8),
                        CustomInputField(
                          controller: homeCubit.sudentIDController,
                          type: TextInputType.number,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'StudentID',
                            val: value,
                            fieldType: ValidationType.number,
                          ),
                          label: 'StudentID',
                          icon: Icons.numbers,
                        ),
                        const SizedBox(height: 8),
                        CustomInputField(
                          controller: homeCubit.emailController,
                          type: TextInputType.text,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Email',
                            val: value,
                            fieldType: ValidationType.text,
                          ),
                          label: 'Email',
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 8),
                        CustomInputField(
                          controller: homeCubit.genderController,
                          type: TextInputType.text,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Gender',
                            val: value,
                            fieldType: ValidationType.text,
                          ),
                          label: 'Gender',
                          icon: Icons.person_rounded,
                        ),
                        const SizedBox(height: 8),
                        CustomInputField(
                          controller: homeCubit.levelController,
                          type: TextInputType.number,
                          validate: (value) => checkFieldValidation(
                            fieldName: 'Level',
                            val: value,
                            fieldType: ValidationType.number,
                          ),
                          label: 'Level',
                          icon: Icons.numbers,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 200),
                  MainBtn(
                    title: "Update",
                    onPressed: () async {
                      if (homeCubit.profileImage != null) {
                        homeCubit.profilePictureUrl =
                            await homeCubit.uploadPhotoAndGetDownloadUrl(
                                homeCubit.profileImage!);
                        print(
                            '---> profile picture from update profile ${homeCubit.profilePictureUrl}');
                      }
                      if (homeCubit.profilePictureUrl == null) {
                        UserProfile updatedProfile = UserProfile(
                          name: homeCubit.nameController.text,
                          gender: homeCubit.genderController.text,
                          email: homeCubit.emailController.text,
                          studentId: homeCubit.sudentIDController.text,
                          level: int.parse(
                            homeCubit.levelController.text,
                          ),
                        );
                        var responce = await ApiService().put(
                            path: Urls.updateProfile,
                            body: updatedProfile.toJson(),
                            token: AppConst.token);
                        var localresponce = homeCubit.updateUserProfileLocally(
                            updatedProfile: updatedProfile);
                        print(
                            '---responce from ApiServer -> ${responce.toString()}');
                        print(
                            '---localRespoce from sqflite -> ${localresponce.toString()}');
                      } else {
                        UserProfile updatedProfile = UserProfile(
                          name: homeCubit.nameController.text,
                          gender: homeCubit.genderController.text,
                          email: homeCubit.emailController.text,
                          studentId: homeCubit.sudentIDController.text,
                          level: int.parse(homeCubit.levelController.text),
                          profilePhoto: homeCubit.profilePictureUrl,
                        );
                        var responce = await ApiService().put(
                            path: Urls.updateProfile,
                            body: updatedProfile.toJson(),
                            token: AppConst.token);
                        var localresponce = homeCubit.updateUserProfileLocally(
                            updatedProfile: updatedProfile);
                        print(
                            '---responce from ApiServer -> ${responce.toString()}');
                        print(
                            '---localRespoce from sqflite -> ${localresponce.toString()}');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
