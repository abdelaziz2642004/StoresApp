import 'dart:typed_data';

import 'package:store_app/Models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Studentprovider extends StateNotifier<Student> {
  // Constructor
  Studentprovider()
    : super(
        Student(
          fullName: 'fullName',
          email: 'email',
          studentID: 0,
          password: 'password',
        ),
      );

  // Method to reset the state
  void empty() {
    state = Student(
      fullName: 'fullName',
      email: 'email',
      studentID: 0,
      password: 'password',
    );
  }

  // Method to update full name
  void updateFullName(String newFullName) {
    state = Student(
      fullName: newFullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: state.password,
      imageBytes: state.imageBytes,
    );
  }

  // Method to update gender
  void updateGender(String? newGender) {
    state = Student(
      fullName: state.fullName,
      gender: newGender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: state.password,
      imageBytes: state.imageBytes,
    );
  }

  // Met

  // Method to update level
  void updateLevel(int? newLevel) {
    state = Student(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: newLevel,
      password: state.password,
      imageBytes: state.imageBytes,
    );
  }

  // Method to update password
  void updatePassword(String newPassword) {
    state = Student(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: newPassword,
      imageBytes: state.imageBytes,
    );
  }

  // Method to update profile image
  void updateImage(Uint8List? newImageBytes) {
    state = Student(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: state.password,
      imageBytes: newImageBytes,
    );
  }

  // Method to update multiple fields using a map
  void updateStudent(Student student) {
    state = student;
  }
}

// Provider declaration
final studentProvider = StateNotifierProvider<Studentprovider, Student>(
  (ref) => Studentprovider(),
);
