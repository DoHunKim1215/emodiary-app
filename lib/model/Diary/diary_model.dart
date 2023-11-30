import 'package:intl/intl.dart';

class DiaryModel {
  final int id;
  final DateTime createdDate;
  final DateTime whichDate;
  final String title;
  final String content;
  final String imageUrl;

  const DiaryModel({
    required this.id,
    required this.createdDate,
    required this.whichDate,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
      id: json["id"],
      createdDate: DateFormat("yyyy-MM-dd").parse(json["created_date"]),
      whichDate: DateFormat("yyyy-MM-dd").parse(json["which_date"]),
      title: json["title"],
      content: json["content"],
      imageUrl: json["image_url"],
    );
  }
}
