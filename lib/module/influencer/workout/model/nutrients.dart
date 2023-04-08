// import 'package:json_annotation/json_annotation.dart';
part 'nutrients.g.dart';

class NutrientModel {
  String? image;
  String? title;
  List<String>? nutrientImages;
  NutrientModel({
    this.image,
    this.title,
    this.nutrientImages,
  });

  factory NutrientModel.fromJson(Map<String, dynamic> json) => NutrientModel(
        image: json['image'] as String?,
        title: json['title'] as String?,
        nutrientImages: (json['nutrientImages'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
      );

  Map<String, dynamic> toJson(NutrientModel instance) => <String, dynamic>{
        'image': instance.image,
        'title': instance.title,
        'nutrientImages': instance.nutrientImages,
      };
  // factory NutrientModel.fromJson(Map<String, dynamic> json) =>
  //     _$NutrientModelFromJson(json);

  // Map<String, dynamic> toJson() => _$NutrientModelToJson(this);
}
