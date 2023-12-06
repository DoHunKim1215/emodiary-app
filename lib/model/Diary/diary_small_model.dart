class DiarySmallModel {
  final int id;
  final String imageUrl;

  const DiarySmallModel({
    required this.id,
    required this.imageUrl,
  });

  factory DiarySmallModel.fromJson(
      Map<String, dynamic> json, String serverUrl) {
    return DiarySmallModel(
      id: json["id"],
      imageUrl: json["image_url"] == null
          ? ""
          : "$serverUrl/images/${json["image_url"]}",
    );
  }
}
