// import 'package:json_annotation/json_annotation.dart';
part 'rounds_response.g.dart';

// @JsonSerializable()
class RoundsResponseModel {
  List<RoundsData> data;
  RoundsResponseModel(this.data);

  factory RoundsResponseModel.fromJson(Map<String, dynamic> json) =>
      RoundsResponseModel(
        (json['data'] as List<dynamic>)
            .map((e) => RoundsData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson(RoundsResponseModel instance) =>
      <String, dynamic>{
        'data': instance.data,
      };
  // factory RoundsResponseModel.fromJson(Map<String, dynamic> json) =>
  //     _$RoundsResponseModelFromJson(json);

  // Map<String, dynamic> toJson() => _$RoundsResponseModelToJson(this);
}

class RoundsData {
  final int? workoutDayExerciseId;
  final String? subType;
  final String? exerciseTime;
  final int? id;

  RoundsData({
    this.workoutDayExerciseId,
    this.subType,
    this.exerciseTime,
    this.id,
  });

  factory RoundsData.fromJson(Map<String, dynamic> json) => RoundsData(
        workoutDayExerciseId: json['workoutDayExerciseId'] as int?,
        subType: json['subType'] as String?,
        exerciseTime: json['exerciseTime'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson(RoundsData instance) => <String, dynamic>{
        'workoutDayExerciseId': instance.workoutDayExerciseId,
        'subType': instance.subType,
        'id': instance.id,
      };
  // factory RoundsData.fromJson(Map<String, dynamic> json) =>
  //     _$RoundsDataFromJson(json);

  // Map<String, dynamic> toJson() => _$RoundsDataToJson(this);
}
