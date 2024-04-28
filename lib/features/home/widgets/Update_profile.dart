import 'package:flutter/material.dart';
import 'package:mobile_assignment_1/core/models/user_info/user_info.dart';
import 'package:mobile_assignment_1/core/utils/constatns.dart';

class UpdateProfileScreen extends StatefulWidget {


  UpdateProfileScreen(

  );

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController emailController;
  late TextEditingController studentIdController;
  late TextEditingController levelController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: AppConst.userProfile!.name);
    genderController = TextEditingController(text: AppConst.userProfile!.gender);
    emailController = TextEditingController(text: AppConst.userProfile!.email);
    studentIdController =
        TextEditingController(text: AppConst.userProfile!.studentId);
    levelController =
        TextEditingController(text: AppConst.userProfile!.level.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Gender'),
            TextFormField(
              controller: genderController,
              decoration: InputDecoration(
                hintText: 'Enter your gender',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Email'),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Student ID'),
            TextFormField(
              controller: studentIdController,
              decoration: InputDecoration(
                hintText: 'Enter your student ID',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Level'),
            TextFormField(
              controller: levelController,
              decoration: InputDecoration(
                hintText: 'Enter your level',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the updated profile
                UserProfile updatedProfile = UserProfile(
                  name: nameController.text,
                  gender: genderController.text,
                  email: emailController.text,
                  studentId: studentIdController.text,
                  level: int.parse(levelController.text),
                  profilePhoto: '',
                );
                // Update the profile using HTTP request
                // Redirect to home screen or show success message
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    emailController.dispose();
    studentIdController.dispose();
    levelController.dispose();
    super.dispose();
  }
}
