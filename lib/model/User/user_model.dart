import 'package:emodiary/util/enum/login_provider.dart';

class UserModel {
  final int id;
  final String nickname;
  final ELoginProvider loginProvider;
  final String profileImageUrl;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.nickname,
    required this.loginProvider,
    required this.profileImageUrl,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      nickname: json["nickname"],
      loginProvider: ELoginProvider.getByName(json["provider"]),
      profileImageUrl: json["profile_image_url"],
      phoneNumber: json["phone_number"],
    );
  }
}
