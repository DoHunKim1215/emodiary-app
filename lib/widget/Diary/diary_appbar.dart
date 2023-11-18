import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiaryAppBar extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const DiaryAppBar({
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
      leadingWidth: 60,
      leading: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        style: IconButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
        ),
        icon: SvgPicture.asset(
          "assets/icons/arrow-left.svg",
          width: 24.0,
          height: 24.0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
