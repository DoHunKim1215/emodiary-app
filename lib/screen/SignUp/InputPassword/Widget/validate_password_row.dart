import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ValidatePasswordRow extends StatelessWidget {
  final TextEditingController controller;

  const ValidatePasswordRow({
    super.key,
    required this.controller,
  });

  bool contains(RegExp regex) {
    return controller.text.contains(regex);
  }

  @override
  Widget build(BuildContext context) {
    final containAlphabet = contains(RegExp(r'[a-zA-Z]'));
    final containNumeric = contains(RegExp(r'[0-9]'));
    final containSpecialChar =
        contains(RegExp(r"[~!@#$%^&*()_+\-=\[\]{};:\\|,.<>/?]"));
    final isLongerThanEight = controller.text.length >= 8;

    return Row(
      children: [
        containAlphabet
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
          "영문 포함",
          style: TextStyle(
            color: containAlphabet
                ? const Color(0xFF7541EF)
                : const Color(0xFFCCD1D9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        containNumeric
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
          "숫자 포함",
          style: TextStyle(
            color: containNumeric
                ? const Color(0xFF7541EF)
                : const Color(0xFFCCD1D9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        containSpecialChar
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
          "특수문자 포함",
          style: TextStyle(
            color: containSpecialChar
                ? const Color(0xFF7541EF)
                : const Color(0xFFCCD1D9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        isLongerThanEight
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
          "8자리 이상",
          style: TextStyle(
            color: isLongerThanEight
                ? const Color(0xFF7541EF)
                : const Color(0xFFCCD1D9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
