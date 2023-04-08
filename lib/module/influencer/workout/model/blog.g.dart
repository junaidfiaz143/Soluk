// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
      image: json['image'] as String?,
      blogTitle: json['blogTitle'] as String?,
      blogDescription: json['blogDescription'] as String?,
    );

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'image': instance.image,
      'blogTitle': instance.blogTitle,
      'blogDescription': instance.blogDescription,
    };
