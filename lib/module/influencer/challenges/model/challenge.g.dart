// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) =>
    ChallengeModel(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      assetUrl: json['assetUrl'] as String?,
      assetType: json['assetType'] as String?,
      title: json['title'] as String?,
      badge: json['badge'] as String?,
      maxUsers: json['maxUsers'] as int?,
      description: json['description'] as String?,
      challengeExpiry: json['challengeExpiry'] as String?,
      challengeStatus: json['challengeStatus'] as String?,
      isActive: json['isActive'] as int?,
      createBy: json['createBy'] as int?,
      createdDate: json['createdDate'] as String?,
      modifiedBy: json['modifiedBy'],
      modifiedDate: json['modifiedDate'],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ChallengeModelToJson(ChallengeModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'assetUrl': instance.assetUrl,
      'assetType': instance.assetType,
      'title': instance.title,
      'badge': instance.badge,
      'maxUsers': instance.maxUsers,
      'description': instance.description,
      'challengeExpiry': instance.challengeExpiry,
      'challengeStatus': instance.challengeStatus,
      'isActive': instance.isActive,
      'createBy': instance.createBy,
      'createdDate': instance.createdDate,
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

GetAllChallenges _$GetAllChallengesFromJson(Map<String, dynamic> json) =>
    GetAllChallenges(
      allChallenges: (json['responseDetails'] as List<dynamic>?)
          ?.map((e) => ChallengeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllChallengesToJson(GetAllChallenges instance) =>
    <String, dynamic>{
      'responseDetails': instance.allChallenges,
    };
