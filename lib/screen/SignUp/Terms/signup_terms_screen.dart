import 'package:emodiary/screen/SignUp/Terms/Widget/all_agree_check_row.dart';
import 'package:emodiary/screen/SignUp/Terms/Widget/signup_terms_title.dart';
import 'package:emodiary/screen/SignUp/Terms/Widget/terms_check_rows.dart';
import 'package:emodiary/viewModel/SignUp/signup_terms_view_model.dart';
import 'package:emodiary/widget/base/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpTermsScreen extends StatelessWidget {
  final SignUpTermsViewModel viewModel = Get.put(SignUpTermsViewModel());

  final void Function() onTapNext;

  SignUpTermsScreen({super.key, required this.onTapNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignUpTermsTitle(),
              const SizedBox(
                height: 45,
              ),
              AllAgreeCheckRow(viewModel: viewModel),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Container(
                  height: 1,
                  color: const Color(0xFFE6E9ED),
                ),
              ),
              TermsCheckRows(viewModel: viewModel),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => CommonBottomButton(
                    text: "다음",
                    disabledText: "필수 항목에 동의해주세요!",
                    onPressed:
                        viewModel.isCheckedRequiredAll() ? onTapNext : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
