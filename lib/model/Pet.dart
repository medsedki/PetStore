import 'Category.dart';
import 'Tags.dart';

class Pet {
  int? id;
  Category? category;
  String? name;
  List<String> photoUrls = [];
  List<Tags> tags = [];
  String? status;

  Pet({
    this.id,
    this.category,
    this.name,
    required this.photoUrls,
    required this.tags,
    this.status,
  });

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    name = json['name'];
    photoUrls = json['photoUrls'].cast<String>();
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags.add(Tags.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (category != null) {
      data['category'] = category?.toJson();
    }
    data['name'] = name;
    data['photoUrls'] = photoUrls;
    if (tags != null) {
      data['tags'] = tags.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}
