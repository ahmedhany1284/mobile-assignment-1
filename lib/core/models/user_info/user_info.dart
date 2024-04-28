class UserProfile {
  final String? name;
  final String? gender;
  final String? email;
  final String? studentId;
  final int? level;
  final String? profilePhoto;

  UserProfile({
     this.name,
     this.gender,
     this.email,
     this.studentId,
     this.level,
     this.profilePhoto,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      studentId: json['studentId'] ?? '',
      level: json['level'] ?? 0,
      profilePhoto: json['profilePhoto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'studentId': studentId,
      'level': level,
      'profilePhoto': profilePhoto,
    };
  }
}
