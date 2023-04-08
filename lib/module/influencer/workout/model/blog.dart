part 'blog.g.dart';

class BlogModel {
  String? image;
  String? blogTitle;
  String? blogDescription;

  BlogModel({
    this.image,
    this.blogTitle,
    this.blogDescription,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        image: json['image'] as String?,
        blogTitle: json['blogTitle'] as String?,
        blogDescription: json['blogDescription'] as String?,
      );

  Map<String, dynamic> toJson(BlogModel instance) => <String, dynamic>{
        'image': instance.image,
        'blogTitle': instance.blogTitle,
        'blogDescription': instance.blogDescription,
      };

// factory BlogModel.fromJson(Map<String, dynamic> json) =>
//     _$BlogModelFromJson(json);

// Map<String, dynamic> toJson() => _$BlogModelToJson(this);
}
