import 'package:socialx/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      name: (json['name'] ?? '') as String,
    );
  }

  UserModel copyWith({String? id, String? email, String? name}) {
  return UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
  );
}

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }
}


