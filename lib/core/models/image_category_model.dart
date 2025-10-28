// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImageCategoryModel {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;
  ImageCategoryModel({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  ImageCategoryModel copyWith({
    int? id,
    String? dateCreated,
    String? dateCreatedGmt,
    String? dateModified,
    String? dateModifiedGmt,
    String? src,
    String? name,
    String? alt,
  }) {
    return ImageCategoryModel(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
      dateModified: dateModified ?? this.dateModified,
      dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
      src: src ?? this.src,
      name: name ?? this.name,
      alt: alt ?? this.alt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateCreated': dateCreated,
      'dateCreatedGmt': dateCreatedGmt,
      'dateModified': dateModified,
      'dateModifiedGmt': dateModifiedGmt,
      'src': src,
      'name': name,
      'alt': alt,
    };
  }

  factory ImageCategoryModel.fromMap(Map<String, dynamic> map) {
    return ImageCategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      dateCreated: map['dateCreated'] != null ? map['dateCreated'] as String : null,
      dateCreatedGmt: map['dateCreatedGmt'] != null ? map['dateCreatedGmt'] as String : null,
      dateModified: map['dateModified'] != null ? map['dateModified'] as String : null,
      dateModifiedGmt: map['dateModifiedGmt'] != null ? map['dateModifiedGmt'] as String : null,
      src: map['src'] != null ? map['src'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      alt: map['alt'] != null ? map['alt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageCategoryModel.fromJson(String source) => ImageCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImageCategoryModel(id: $id, dateCreated: $dateCreated, dateCreatedGmt: $dateCreatedGmt, dateModified: $dateModified, dateModifiedGmt: $dateModifiedGmt, src: $src, name: $name, alt: $alt)';
  }

  @override
  bool operator ==(covariant ImageCategoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.dateCreated == dateCreated &&
      other.dateCreatedGmt == dateCreatedGmt &&
      other.dateModified == dateModified &&
      other.dateModifiedGmt == dateModifiedGmt &&
      other.src == src &&
      other.name == name &&
      other.alt == alt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      dateCreated.hashCode ^
      dateCreatedGmt.hashCode ^
      dateModified.hashCode ^
      dateModifiedGmt.hashCode ^
      src.hashCode ^
      name.hashCode ^
      alt.hashCode;
  }
}
