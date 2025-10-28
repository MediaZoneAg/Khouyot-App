// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EditProfileModel {
  final String name;
  final String email;
  EditProfileModel({
    required this.name,
    required this.email,
  });
  

  EditProfileModel copyWith({
    String? name,
    String? email,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory EditProfileModel.fromMap(Map<String, dynamic> map) {
    return EditProfileModel(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileModel.fromJson(String source) => EditProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EditProfileModel(name: $name, email: $email)';

  @override
  bool operator ==(covariant EditProfileModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}
