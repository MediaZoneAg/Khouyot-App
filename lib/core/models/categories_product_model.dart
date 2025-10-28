// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoriesModel {
  final int? id;
  final String? name;
  final String? slug;
  CategoriesModel({
    this.id,
    this.name,
    this.slug,
  });
  

  CategoriesModel copyWith({
    int? id,
    String? name,
    String? slug,
  }) {
    return CategoriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) => CategoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoriesModel(id: $id, name: $name, slug: $slug)';

  @override
  bool operator ==(covariant CategoriesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
