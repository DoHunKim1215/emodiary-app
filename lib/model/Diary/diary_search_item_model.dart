import 'package:intl/intl.dart';

class DiarySearchItemModel {
  final int id;
  final String title;
  final DateTime createdDate;
  final String imageUrl;

  DiarySearchItemModel({
    required this.id,
    required this.title,
    required this.createdDate,
    required this.imageUrl,
  });

  factory DiarySearchItemModel.fromJson(Map<String, dynamic> json) {
    return DiarySearchItemModel(
      id: json["id"],
      title: json["title"],
      createdDate: DateFormat("yyyy-MM-dd").parse(json["created_date"]),
      imageUrl: json["image_url"],
    );
  }
}
