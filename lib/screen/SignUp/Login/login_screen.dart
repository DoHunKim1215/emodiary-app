import 'package:emodiary/widget/SignUp/signup_appbar.dart';
import 'package:emodiary/widget/base/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const int idAndPasswordMaxLength = 100;

  late TextEditingController _idCtrl;
  late TextEditingController _passwordCtrl;

  @override
  void initState() {
    super.initState();
    _idCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  bool canSend() {
    return _idCtrl.text.isNotEmpty && _passwordCtrl.text.isNotEmpty;
  }

  void onTapNext() {
    Get.offAllNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SignUpAppBar(
              title: "로그인",
              onPressed: () {
                Get.offAllNamed("/login");
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "아이디",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      TextField(
                        controller: _idCtrl,
                        onChanged: (_) {
                          setState(() {});
                        },
                        maxLength: idAndPasswordMaxLength,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: 'emodiary@emodiary.com',
                          hintStyle: const TextStyle(
                            color: Color(0xFFCCD1D9),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minHeight: 20,
                            minWidth: 20,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _idCtrl.clear,
                            child: SvgPicture.asset(
                              "assets/icons/clear.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 0.0,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE6E9ED),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE6E9ED),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "비밀번호",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      TextField(
                        controller: _passwordCtrl,
                        onChanged: (_) {
                          setState(() {});
                        },
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        maxLength: idAndPasswordMaxLength,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: '비밀번호를 다시 입력해주세요.',
                          hintStyle: const TextStyle(
                            color: Color(0xFFCCD1D9),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minHeight: 20,
                            minWidth: 20,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _passwordCtrl.clear,
                            child: SvgPicture.asset(
                              "assets/icons/clear.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 0.0,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE6E9ED),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE6E9ED),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "아이디 찾기",
                            style: TextStyle(
                              color: Color(0xFFAAB2BD),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.42,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                              color: Color(0xFFAAB2BD),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.42,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "비밀번호 찾기",
                            style: TextStyle(
                              color: Color(0xFFAAB2BD),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.42,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonBottomButton(
                        text: "다음",
                        disabledText: "아이디와 비밀번호를 입력해주세요!",
                        onPressed: canSend() ? onTapNext : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
