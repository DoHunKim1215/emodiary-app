import 'package:flutter/material.dart';

class SignUpTermsTitle extends StatelessWidget {
  const SignUpTermsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text(
              "Emodiary",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 1.6,
              ),
            ),
            Text(
              " 서비스 이용약관에",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "동의해주세요.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
