// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AboutMeInfoAdapter extends TypeAdapter<AboutMeInfo> {
  @override
  final int typeId = 0;

  @override
  AboutMeInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AboutMeInfo(
      profileImage: fields[0] as String?,
      introVideo: fields[1] as String?,
      workoutTitle: fields[2] as String?,
      tags: (fields[3] as List?)?.cast<String>(),
      goals: fields[4] as String?,
      credential: fields[5] as String?,
      requirements: fields[6] as String?,
      intro: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AboutMeInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.profileImage)
      ..writeByte(1)
      ..write(obj.introVideo)
      ..writeByte(2)
      ..write(obj.workoutTitle)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.goals)
      ..writeByte(5)
      ..write(obj.credential)
      ..writeByte(6)
      ..write(obj.requirements)
      ..writeByte(7)
      ..write(obj.intro);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AboutMeInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
