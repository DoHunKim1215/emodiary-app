import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';
import 'package:flutter/material.dart';

class DiaryTitleField extends StatelessWidget {
  final DiaryWritingViewModel viewModel;

  const DiaryTitleField({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: viewModel.titleCtrl,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      maxLength: DiaryWritingViewModel.titleMaxLength,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: const Color(0xFFFFD66C),
      decoration: const InputDecoration(
        counterText: "",
        hintText: '일기 제목을 입력해주세요. (최대 40자)',
        hintStyle: TextStyle(
          color: Color(0xFF787A93),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 0.0,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFD66C),
            width: 3.0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFD66C),
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
