import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:store_app/Models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Studentprovider extends StateNotifier<Student> {
  // Constructor
  Studentprovider() : super(_getInitialStudent());

  // Get initial student from Hive or return default
  static Student _getInitialStudent() {
    var box = Hive.box('student');
    if (box.isEmpty) {
      return Student(
        fullName: 'fullName',
        email: 'email',
        studentID: 0,
        password: 'password',
      );
    } else {
      final data = box.get('student');
      if (data is Student) {
        return data;
      } else {
        return Student(
          fullName: 'fullName',
          email: 'email',
          studentID: 0,
          password: 'password',
        );
      }
    }
  }

  // Method to reset the state
  void empty() async {
    state = Student(
      fullName: 'fullName',
      email: 'email',
      studentID: 0,
      password: 'password',
    );
    final box = await Hive.openBox('student');
    box.clear();
  }

  // Method to update full name
  void updateFullName(String newFullName) async {
    state = Student(
      fullName: newFullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: state.password,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('student');
    await box.put('student', state);
  }

  // Method to update gender
  void updateGender(String? newGender) async {
    state = Student(
      fullName: state.fullName,
      gender: newGender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: state.password,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('student');
    await box.put('student', state);
  }

  // Met

  // Method to update level
  void updateLevel(int? newLevel) async {
    state = Student(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: newLevel,
      password: state.password,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('student');
    await box.put('student', state);
  }

  // Method to update password
  void updatePassword(String newPassword) async {
    state = Student(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: newPassword,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('student');
    await box.put('student', state);
  }

  // Method to update profile image
  void updateImage(Uint8List? newImageBytes) async {
    state = Student(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      studentID: state.studentID,
      level: state.level,
      password: state.password,
      imageBytes: newImageBytes,
    );
    final box = await Hive.openBox('student');
    await box.put('student', state);
  }

  // Method to update multiple fields using a map
  void updateStudent(Student student) async {
    state = student;
    final box = await Hive.openBox('student');
    await box.put('student', state);
    print(box.get('student'));
  }
}

// Provider declaration
final studentProvider = StateNotifierProvider<Studentprovider, Student>(
  (ref) => Studentprovider(),
);
