import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/widget/base/no_splash_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpEntryScreen extends StatelessWidget {
  const SignUpEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                      width: 116,
                      height: 113,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "나만의 추억을\n그림일기로 간직해볼까요?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(
                        "assets/images/speech-bubble.png",
                        width: 208,
                        height: 72,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 16,
                        ),
                        child: Text(
                          "🖌️ 먼저 로그인이 필요해요",
                          style: TextStyle(
                            color: Color(0xFF656D78),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.42,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NoSplashIconButton(
                        onPressed: () {
                          logOnDev("KAKAO!");
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/kakao-button.svg",
                          width: 57,
                          height: 57,
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      NoSplashIconButton(
                        onPressed: () {
                          logOnDev("NAVER!");
                        },
                        icon: Image.asset(
                          "assets/icons/naver-button.png",
                          width: 57,
                          height: 57,
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      NoSplashIconButton(
                        onPressed: () {
                          logOnDev("GOOGLE!");
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/google-button.svg",
                          width: 57,
                          height: 57,
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      NoSplashIconButton(
                        onPressed: () {
                          logOnDev("APPLE!");
                        },
                        icon: Image.asset(
                          "assets/icons/apple-button.png",
                          width: 57,
                          height: 57,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  TextButton(
                    onPressed: () {
                      logOnDev("문의!");
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text(
                      "문의하기",
                      style: TextStyle(
                        color: Color(0xFFAAB2BD),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.42,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
