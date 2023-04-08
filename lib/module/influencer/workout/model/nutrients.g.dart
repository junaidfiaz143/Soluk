// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutrientModel _$NutrientModelFromJson(Map<String, dynamic> json) =>
    NutrientModel(
      image: json['image'] as String?,
      title: json['title'] as String?,
      nutrientImages: (json['nutrientImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NutrientModelToJson(NutrientModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'nutrientImages': instance.nutrientImages,
    };
