// import 'package:json_annotation/json_annotation.dart';
part 'link.g.dart';

class LinkModel {
  String? image;
  String? title;
  String? link;
  LinkModel({
    this.image,
    this.title,
    this.link,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        image: json['image'] as String?,
        title: json['title'] as String?,
        link: json['link'] as String?,
      );

  Map<String, dynamic> toJson(LinkModel instance) => <String, dynamic>{
        'image': instance.image,
        'title': instance.title,
        'link': instance.link,
      };
  // factory LinkModel.fromJson(Map<String, dynamic> json) =>
  //     _$LinkModelFromJson(json);

  // Map<String, dynamic> toJson() => _$LinkModelToJson(this);
}
