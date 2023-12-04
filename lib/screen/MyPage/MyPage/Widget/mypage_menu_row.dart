import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPageMenuRow extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final String? followingText;
  final void Function()? onPressed;

  const MyPageMenuRow({
    super.key,
    this.followingText,
    this.onPressed,
    this.titleColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF7541EF),
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 10.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor ?? Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          Row(
            children: [
              if (followingText != null)
                Text(
                  followingText!,
                  style: const TextStyle(
                    color: Color(0xFF878786),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              const SizedBox(
                width: 4,
              ),
              if (followingText != null)
                SvgPicture.asset(
                  "assets/icons/arrow-forward.svg",
                  width: 18,
                  height: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
