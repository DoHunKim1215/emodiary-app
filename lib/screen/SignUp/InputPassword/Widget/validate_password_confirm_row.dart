import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ValidatePasswordConfirmRow extends StatelessWidget {
  final TextEditingController passwordCtrl;
  final TextEditingController passwordConfirmCtrl;

  const ValidatePasswordConfirmRow({
    super.key,
    required this.passwordCtrl,
    required this.passwordConfirmCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final isSame = passwordCtrl.text.isNotEmpty &&
        passwordConfirmCtrl.text.isNotEmpty &&
        passwordCtrl.text == passwordConfirmCtrl.text;

    return Row(
      children: [
        isSame
            ? SvgPicture.asset(
                "assets/icons/check.svg",
                width: 20,
                height: 20,
              )
            : SvgPicture.asset(
                "assets/icons/unchecked.svg",
                width: 20,
                height: 20,
              ),
        const SizedBox(
          width: 2,
        ),
        Text(
          "비밀번호 일치",
          style: TextStyle(
            color: isSame ? const Color(0xFF7541EF) : const Color(0xFFCCD1D9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
