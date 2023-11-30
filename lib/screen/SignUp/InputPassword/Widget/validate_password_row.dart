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
    return Row(
      children: [
        Row(
          children: [
            contains(RegExp(r'[a-zA-Z]'))
                ? SvgPicture.asset("assets/icons/check.svg")
                : SvgPicture.asset("assets/icons/check.svg"),
          ],
        )
      ],
    );
  }
}
