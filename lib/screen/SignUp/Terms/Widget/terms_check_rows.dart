import 'package:emodiary/screen/SignUp/Terms/Widget/terms_detail_screen.dart';
import 'package:emodiary/util/enum/signup_terms.dart';
import 'package:emodiary/viewModel/SignUp/signup_terms_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TermsCheckRows extends StatelessWidget {
  final SignUpTermsViewModel viewModel;

  const TermsCheckRows({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        ESignUpTerms.values.length,
        (index) => Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: viewModel.toggle(index),
                  child: Row(
                    children: [
                      Obx(
                        () => viewModel.isChecked[index]
                            ? SvgPicture.asset(
                                "assets/icons/check.svg",
                                width: 24,
                                height: 24,
                              )
                            : SvgPicture.asset(
                                "assets/icons/unchecked.svg",
                                width: 24,
                                height: 24,
                              ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "[${ESignUpTerms.values[index].isRequired ? "필수" : "선택"}] ${ESignUpTerms.values[index].title}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    showGeneralDialog(
                      barrierDismissible: false,
                      context: context,
                      transitionDuration: const Duration(
                        milliseconds: 250,
                      ),
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 1.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                          ),
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const TermsDetailScreen();
                      },
                    );
                  },
                  child: const Text(
                    "보기",
                    style: TextStyle(
                      color: Color(0xFFAAB2BD),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      height: 1.7,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFFAAB2BD),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
