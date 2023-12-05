class SharedDiaryModel {
  final String uuid;
  final String authCode;

  SharedDiaryModel({
    required this.uuid,
    required this.authCode,
  });

  factory SharedDiaryModel.fromJson(Map<String, dynamic> json) {
    return SharedDiaryModel(
      uuid: json["uuid"],
      authCode: json["auth_code"],
    );
  }
}
