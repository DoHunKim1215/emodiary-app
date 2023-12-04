import 'package:emodiary/model/Diary/diary_model.dart';
import 'package:emodiary/provider/Diary/diary_provider.dart';
import 'package:get/get.dart';

class DiaryReadViewModel extends GetxController {
  Rxn<DiaryModel> diaryModel = Rxn<DiaryModel>(null);

  final DiaryProvider diaryProvider = DiaryProvider();

  String getTitle() {
    return diaryModel.value!.title;
  }

  String getContent() {
    return diaryModel.value!.content;
  }

  String getImageUrl() {
    return diaryModel.value!.imageUrl;
  }

  Future<void> getDiary(int id) async {
    try {
      diaryModel.value = await diaryProvider.getDiary(id);
    } on Exception catch (e) {
      diaryModel.value = null;
    } finally {
      diaryModel.refresh();
    }
  }

  Future<void> deleteDiary(int id) async {
    try {
      await diaryProvider.deleteDiary(id);
      diaryModel.value = null;
      diaryModel.refresh();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
