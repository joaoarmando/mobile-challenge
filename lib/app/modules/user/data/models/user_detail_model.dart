
import '../../domain/entities/user_entity.dart';

class UserDetailModel {
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final String? email;
  final String? location;

  UserDetailModel({required this.login, required this.bio, required this.name, 
    required this.location, required this.email, required this.avatarUrl});

  factory UserDetailModel.fromJson(Map<String,dynamic> json) => UserDetailModel(
    login: json["login"],
    bio: json["bio"],
    name: json["name"],
    email: json["email"],
    location: json["location"],
    avatarUrl: json["avatar_url"]
  );

   Map<String, dynamic> toMap() {
    return {
      'login': login,
      'bio': bio,
      'name': name,
      'location': location,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }

  factory UserDetailModel.fromEntity(UserEntity entity) => UserDetailModel(
    login: entity.login,
    bio: entity.bio,
    name: entity.name,
    location: entity.location,
    email: entity.email,
    avatarUrl: entity.avatarUrl,
  );

  UserEntity toEntity() => UserEntity(
    login: login, 
    bio: bio, 
    name: name,
    email: email,
    location: location, 
    avatarUrl: avatarUrl,
  );
}