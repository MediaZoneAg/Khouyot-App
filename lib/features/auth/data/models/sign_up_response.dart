// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpResponse {
  String? message;
  int? userId;
  final String? token;
  String? name;
  String? email;
  SignUpResponse({
    this.message,
    this.userId,
    this.token,
    this.name,
    this.email,
  });
  

  SignUpResponse copyWith({
    String? message,
    int? userId,
    String? token,
    String? name,
    String? email,
  }) {
    return SignUpResponse(
      message: message ?? this.message,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'userId': userId,
      'token': token,
      'name': name,
      'email': email,
    };
  }

  factory SignUpResponse.fromMap(Map<String, dynamic> map) {
    return SignUpResponse(
      message: map['message'] != null ? map['message'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      token: map['token'] != null ? map['token'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpResponse.fromJson(String source) => SignUpResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpResponse(message: $message, userId: $userId, token: $token, name: $name, email: $email)';
  }

  @override
  bool operator ==(covariant SignUpResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.userId == userId &&
      other.token == token &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode {
    return message.hashCode ^
      userId.hashCode ^
      token.hashCode ^
      name.hashCode ^
      email.hashCode;
  }
}
