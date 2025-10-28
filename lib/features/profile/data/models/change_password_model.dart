// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChangePaswwordModel {
  final String oldPassword;
  final String newPassword;
  ChangePaswwordModel({
    required this.oldPassword,
    required this.newPassword,
  });
  

  ChangePaswwordModel copyWith({
    String? oldPassword,
    String? newPassword,
  }) {
    return ChangePaswwordModel(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }

  factory ChangePaswwordModel.fromMap(Map<String, dynamic> map) {
    return ChangePaswwordModel(
      oldPassword: map['old_password'] as String,
      newPassword: map['new_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePaswwordModel.fromJson(String source) => ChangePaswwordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChangePaswwordModel(old_password: $oldPassword, new_password: $newPassword)';

  @override
  bool operator ==(covariant ChangePaswwordModel other) {
    if (identical(this, other)) return true;
  
    return
      other.oldPassword == oldPassword &&
      other.newPassword == newPassword;
  }

  @override
  int get hashCode => oldPassword.hashCode ^ newPassword.hashCode;
}
