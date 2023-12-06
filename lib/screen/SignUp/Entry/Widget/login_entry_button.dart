import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginEntryButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool isLogin;

  const LoginEntryButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(3.5, 3.5), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              isLogin ? const Color(0xFFE8DCFF) : const Color(0xFFFFE0BE),
          foregroundColor:
              isLogin ? const Color(0xFFE8DCFF) : const Color(0xFFFFE0BE),
          splashFactory: NoSplash.splashFactory,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                left: -10,
                bottom: -20,
                child: SvgPicture.asset(
                  isLogin
                      ? "assets/icons/emotion-home-good.svg"
                      : "assets/icons/emotion-home-soso.svg",
                  width: 90,
                  height: 90,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    height: 1.44,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
