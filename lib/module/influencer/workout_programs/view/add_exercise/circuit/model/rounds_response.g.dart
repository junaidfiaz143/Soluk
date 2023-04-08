// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rounds_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoundsResponseModel _$RoundsResponseModelFromJson(Map<String, dynamic> json) =>
    RoundsResponseModel(
      (json['data'] as List<dynamic>)
          .map((e) => RoundsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoundsResponseModelToJson(
        RoundsResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

RoundsData _$RoundsDataFromJson(Map<String, dynamic> json) => RoundsData(
      workoutDayExerciseId: json['workoutDayExerciseId'] as int?,
      subType: json['subType'] as String?,
      exerciseTime: json['exerciseTime'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$RoundsDataToJson(RoundsData instance) =>
    <String, dynamic>{
      'workoutDayExerciseId': instance.workoutDayExerciseId,
      'subType': instance.subType,
      'id': instance.id,
    };
