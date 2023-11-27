import 'package:emodiary/viewModel/SignUp/signup_terms_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllAgreeCheckRow extends StatelessWidget {
  final SignUpTermsViewModel viewModel;

  const AllAgreeCheckRow({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.toggleAll();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => viewModel.isCheckedAll()
                ? SvgPicture.asset(
                    "assets/icons/check-box.svg",
                    width: 24,
                    height: 24,
                  )
                : SvgPicture.asset(
                    "assets/icons/unchecked-box.svg",
                    width: 24,
                    height: 24,
                  ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "모두 동의 (선택 정보 포함)",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
