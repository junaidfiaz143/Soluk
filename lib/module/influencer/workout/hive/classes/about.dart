import 'package:hive/hive.dart';

part 'about.g.dart';

@HiveType(typeId: 0)
class AboutMeInfo{
  @HiveField(0)
  String? profileImage;
  @HiveField(1)
  String? introVideo;
  @HiveField(2)
  String? workoutTitle;
  @HiveField(3)
  List<String>? tags;
  @HiveField(4)
  String? goals;
  @HiveField(5)
  String? credential;
  @HiveField(6)
  String? requirements;
  @HiveField(7)
  String? intro;


  AboutMeInfo({
    this.profileImage,
    this.introVideo,
    this.workoutTitle,
    this.tags,
    this.goals,
    this.credential,
    this.requirements,
    this.intro
  });

  AboutMeInfo.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    introVideo = json['introVideo'];
    workoutTitle = json['workoutTitle'];
    goals = json['goals'];
    credential = json['credential'];
    requirements = json['requirements'];
    intro = json['intro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileImage'] = profileImage;
    data['introVideo'] = introVideo;
    data['workoutTitle'] = workoutTitle;
    data['goals'] = goals;
    data['credential'] = credential;
    data['requirements'] = requirements;
    data['intro'] = intro;
    return data;
  }
}
