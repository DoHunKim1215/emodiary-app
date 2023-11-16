import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiaryAppBar extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const DiaryAppBar({super.key, required this.title, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0x00434A54),),
      ),
      //color: var(--12_dark_gray_dark, #434A54);
      // text-align: right;
      // font-family: Pretendard;
      // font-size: 20px;
      // font-style: normal;
      // font-weight: 700;
      // line-height: 149.336%; /* 29.867px */
      centerTitle: true,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leadingWidth: 90,
      leading: TextButton.icon(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        label: const Text(
          "뒤로",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

}