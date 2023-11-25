import 'package:flutter/animation.dart';

class TitleLinearFadeCurve extends Curve {
  final bool isFadeOut;

  const TitleLinearFadeCurve({required this.isFadeOut});

  @override
  double transformInternal(double t) {
    if (isFadeOut) {
      if (0 <= t && t < 0.5) {
        return 2 * t;
      } else {
        return 1;
      }
    } else {
      if (0 <= t && t < 0.5) {
        return 0;
      } else {
        return 2 * t - 1;
      }
    }
  }
}
