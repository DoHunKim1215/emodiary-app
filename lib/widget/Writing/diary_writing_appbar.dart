import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiaryWritingAppBar extends StatelessWidget {
  final String title;
  final void Function()? onPressedLeading;
  final void Function()? onPressedAction;

  const DiaryWritingAppBar({
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
        onPressed: onPressedLeading,
      ),
      actions: onPressedAction == null
          ? null
          : [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  icon: SvgPicture.asset(
                    "assets/icons/share.svg",
                    width: 20.0,
                    height: 20.0,
                  ),
                  onPressed: onPressedAction,
                ),
              ),
            ],
    );
  }
}
