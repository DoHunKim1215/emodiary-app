import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PictureBox extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final void Function() onTap;

  const PictureBox({
    super.key,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 2.0,
              color: isSelected
                  ? const Color(0xFF7541EF)
                  : const Color(0xFFCCD1D9),
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(imagePath),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: SvgPicture.asset(
                  "assets/icons/uncheck-icon.svg",
                  width: 30,
                  height: 30,
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 15,
                  right: 15,
                  child: SvgPicture.asset(
                    "assets/icons/check-icon.svg",
                    width: 24,
                    height: 24,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
