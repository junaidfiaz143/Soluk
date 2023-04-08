part 'challenge.g.dart';

// @JsonSerializable(explicitToJson: true)
class ChallengeModel {
  final int? userId;
  final int? id;
  final String? assetUrl;
  final String? assetType;
  final String? title;
  final String? badge;
  final int? maxUsers;
  final String? description;
  final String? challengeExpiry;
  final String? challengeStatus;
  final int? isActive;
  final int? createBy;
  final String? createdDate;
  final dynamic modifiedBy;
  final dynamic modifiedDate;
  final String? createdAt;
  final String? updatedAt;
  ChallengeModel({
    this.userId,
    this.id,
    this.assetUrl,
    this.assetType,
    this.title,
    this.badge,
    this.maxUsers,
    this.description,
    this.challengeExpiry,
    this.challengeStatus,
    this.isActive,
    this.createBy,
    this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
    this.createdAt,
    this.updatedAt,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => ChallengeModel(
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

  Map<String, dynamic> toJson(ChallengeModel instance) => <String, dynamic>{
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
  // factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
  //     _$ChallengeModelFromJson(json);

  // Map<String, dynamic> toJson() => _$ChallengeModelToJson(this);
}

// @JsonSerializable()
class GetAllChallenges {
  // @JsonKey(name: "responseDetails")
  final List<ChallengeModel>? allChallenges;

  GetAllChallenges({this.allChallenges});

  factory GetAllChallenges.fromJson(Map<String, dynamic> json) =>
      GetAllChallenges(
        allChallenges: (json['responseDetails'] as List<dynamic>?)
            ?.map((e) => ChallengeModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson(GetAllChallenges instance) => <String, dynamic>{
        'responseDetails': instance.allChallenges,
      };

  // factory GetAllChallenges.fromJson(Map<String, dynamic> json) =>
  //     _$GetAllChallengesFromJson(json);

  // Map<String, dynamic> toJson() => _$GetAllChallengesToJson(this);
}
