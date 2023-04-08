// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'influencer_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfluencerInfo _$InfluencerInfoFromJson(Map<String, dynamic> json) =>
    InfluencerInfo(
      id: json['id'] as String?,
      profileImage: json['profileImage'] as String?,
      coverImageVideo: json['coverImageVideo'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      longIntro: json['longIntro'] as String?,
      goals: json['goals'] as String?,
      credentials: json['credentials'] as String?,
      requirements: json['requirements'] as String?,
    );

Map<String, dynamic> _$InfluencerInfoToJson(InfluencerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profileImage': instance.profileImage,
      'coverImageVideo': instance.coverImageVideo,
      'tags': instance.tags,
      'longIntro': instance.longIntro,
      'goals': instance.goals,
      'credentials': instance.credentials,
      'requirements': instance.requirements,
    };
