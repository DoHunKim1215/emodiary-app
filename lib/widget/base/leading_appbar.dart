import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeadingAppBar extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const LeadingAppBar({
    super.key,
    required this.title,
    required this.onPressed,
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
      leadingWidth: 100,
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
