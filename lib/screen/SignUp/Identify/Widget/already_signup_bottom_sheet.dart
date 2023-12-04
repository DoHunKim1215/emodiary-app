import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/widget/base/thin_bottom_button.dart';
import 'package:flutter/material.dart';

class AlreadySignUpBottomSheet extends StatelessWidget {
  const AlreadySignUpBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "기존 계정에 로그인 할까요?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "기존에 로그인되어있는 계정이 존재합니다.\n기존 계정으로 로그인할까요?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF656D78),
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1.38,
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          Row(
            children: [
              Expanded(
                child: ThinBottomButton(
                  onPressed: () {
                    logOnDev("네, 좋아요");
                  },
                  text: "네, 좋아요",
                  isReversed: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: ThinBottomButton(
                  onPressed: () {
                    logOnDev("아니요, 새로운 계정을 만들게요");
                  },
                  text: "아니요, 새로운 계정을 만들게요",
                  isReversed: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
