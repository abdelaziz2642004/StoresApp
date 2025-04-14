import 'package:flutter/services.dart';

class Student {
  String fullName;
  String? gender;
  String email;
  int studentID;
  int? level;
  String password;
  Uint8List? imageBytes;

  Student(
      {required this.fullName,
      this.gender,
      required this.email,
      required this.studentID,
      this.level,
      required this.password,
      this.imageBytes});
}
