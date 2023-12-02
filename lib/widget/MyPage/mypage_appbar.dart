import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPageAppBar extends StatelessWidget {
  final String title;
  final void Function() onPressedLeading;
  final void Function()? onPressedAction;

  const MyPageAppBar({
    super.key,
    required this.title,
    required this.onPressedLeading,
    this.onPressedAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF434A54),
        ),
      ),
      centerTitle: true,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: 90,
      leading: TextButton.icon(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: Colors.white,
        ),
        icon: SvgPicture.asset(
          "assets/icons/arrow-back.svg",
          width: 24.0,
          height: 24.0,
        ),
        label: const Text(
          "뒤로",
          style: TextStyle(
            color: Color(0xFF434A54),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        onPressed: onPressedLeading,
      ),
      actions: onPressedAction == null
          ? null
          : [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "저장",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ],
    );
  }
}
