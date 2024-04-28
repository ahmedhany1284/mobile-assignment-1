import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String name;
  final String? gender;
  final String email;
  final String studentId;
  final int? level;
  final String password;
  final String? profilePhoto;

  const AppUser({
    this.gender,
    this.level,
    required this.password,
    required this.name,
    required this.email,
    required this.studentId,
    this.profilePhoto
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      name: json['name'],
      gender: json['gender'],
      email: json['email'],
      studentId: json['studentId'],
      level: json['level'],
      password: json['password'],
      profilePhoto: json['profilePhoto'],
    );
  }

  @override
  List<Object?> get props => [name, email, studentId, password];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'studentId': studentId,
      'level': level,
      'password': password,
      'profilePhoto': profilePhoto
    };
  }
}
