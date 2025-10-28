// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:khouyot/core/models/image_product_model.dart';

class CategoryModel {
final int? id;
final String? name;
final int? parent;
final String? description;
final List<ImageModel>? images;
  CategoryModel({
    this.id,
    this.name,
    this.parent,
    this.description,
    this.images,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    int? parent,
    String? description,
    List<ImageModel>? images,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parent: parent ?? this.parent,
      description: description ?? this.description,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parent': parent,
      'description': description,
      'images': images?.map((x) => x.toJson()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      parent: map['parent'] != null ? map['parent'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      images: map['images'] != null ? List<ImageModel>.from((map['images'] as List<dynamic>).map<ImageModel?>((x) => ImageModel.fromJson(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, parent: $parent, description: $description, images: $images)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.parent == parent &&
      other.description == description &&
      listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      parent.hashCode ^
      description.hashCode ^
      images.hashCode;
  }
}
