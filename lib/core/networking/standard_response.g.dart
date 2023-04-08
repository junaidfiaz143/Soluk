// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandardResponse _$StandardResponseFromJson(Map<String, dynamic> json) =>
    StandardResponse(
      responseDetails: json['responseDetails'],
      message: json['message'],
      status: json['status'] as String?,
      responseCode: json['responseCode'] as int?,
    );

Map<String, dynamic> _$StandardResponseToJson(StandardResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'responseCode': instance.responseCode,
      'responseDetails': instance.responseDetails,
    };
