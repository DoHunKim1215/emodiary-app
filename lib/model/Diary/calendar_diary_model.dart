class CalendarDiaryModel {
  final int id;
  final String imageUrl;

  CalendarDiaryModel({
    required this.id,
    required this.imageUrl,
  });

  factory CalendarDiaryModel.fromJson(Map<String, dynamic> json) {
    return CalendarDiaryModel(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
}
