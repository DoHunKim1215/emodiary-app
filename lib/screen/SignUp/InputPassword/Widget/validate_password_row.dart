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
    final containLowerCase = contains(RegExp(r'[a-z]'));
    final containUpperCase = contains(RegExp(r'[A-Z]'));
    final containNumeric = contains(RegExp(r'[0-9]'));
    final containSpecialChar = contains(RegExp(r"[!@#%$]"));
    final isLongerThanTen = controller.text.length >= 10;

    return Column(
      children: [
        Row(
          children: [
            containLowerCase
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
              "소문자 포함",
              style: TextStyle(
                color: containLowerCase
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
            containUpperCase
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
              "대문자 포함",
              style: TextStyle(
                color: containUpperCase
                    ? const Color(0xFF7541EF)
                    : const Color(0xFFCCD1D9),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
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
            isLongerThanTen
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
              "10자리 이상",
              style: TextStyle(
                color: isLongerThanTen
                    ? const Color(0xFF7541EF)
                    : const Color(0xFFCCD1D9),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
