// import 'package:json_annotation/json_annotation.dart';
part 'influencer_info.g.dart';

class InfluencerInfo {
  String? id;
  String? profileImage;
  String? coverImageVideo;
  List<String>? tags;
  String? longIntro;
  String? goals;
  String? credentials;
  String? requirements;
  InfluencerInfo({
    this.id,
    this.profileImage,
    this.coverImageVideo,
    this.tags,
    this.longIntro,
    this.goals,
    this.credentials,
    this.requirements,
  });

  factory InfluencerInfo.fromJson(Map<String, dynamic> json) => InfluencerInfo(
        id: json['id'] as String?,
        profileImage: json['profileImage'] as String?,
        coverImageVideo: json['coverImageVideo'] as String?,
        tags:
            (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
        longIntro: json['longIntro'] as String?,
        goals: json['goals'] as String?,
        credentials: json['credentials'] as String?,
        requirements: json['requirements'] as String?,
      );

  Map<String, dynamic> toJson(InfluencerInfo instance) => <String, dynamic>{
        'id': instance.id,
        'profileImage': instance.profileImage,
        'coverImageVideo': instance.coverImageVideo,
        'tags': instance.tags,
        'longIntro': instance.longIntro,
        'goals': instance.goals,
        'credentials': instance.credentials,
        'requirements': instance.requirements,
      };
  // factory InfluencerInfo.fromJson(Map<String, dynamic> json) => _$InfluencerInfoFromJson(json);

  // Map<String, dynamic> toJson() => _$InfluencerInfoToJson(this);
}
