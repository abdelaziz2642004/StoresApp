// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      fullName: fields[0] as String,
      gender: fields[1] as String?,
      email: fields[2] as String,
      studentID: fields[3] as int,
      level: fields[4] as int?,
      password: fields[5] as String,
      imageBytes: fields[6] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.studentID)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.imageBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
