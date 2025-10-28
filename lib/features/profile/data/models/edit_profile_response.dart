// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EditProfileResponse {
  int id;
  String name;
  String email;
  String? url;
  String? description;
  EditProfileResponse({
    required this.id,
    required this.name,
    required this.email,
    this.url,
    this.description,
  });

  EditProfileResponse copyWith({
    int? id,
    String? name,
    String? email,
    String? url,
    String? description,
  }) {
    return EditProfileResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      url: url ?? this.url,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'url': url,
      'description': description,
    };
  }

  factory EditProfileResponse.fromMap(Map<String, dynamic> map) {
    return EditProfileResponse(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      url: map['url'] != null ? map['url'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileResponse.fromJson(String source) => EditProfileResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EditProfileResponse(id: $id, name: $name, email: $email, url: $url, description: $description)';
  }

  @override
  bool operator ==(covariant EditProfileResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.url == url &&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      url.hashCode ^
      description.hashCode;
  }
}
