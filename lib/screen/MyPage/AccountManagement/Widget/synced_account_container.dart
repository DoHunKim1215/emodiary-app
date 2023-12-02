import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SyncedAccountContainer extends StatelessWidget {
  const SyncedAccountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: const Color.fromRGBO(242, 235, 253, 0.30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "연결된 계정",
              style: TextStyle(
                color: Color(0xFF878786),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/small-kakao-button.svg",
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Hong_gildong@nave.com",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
