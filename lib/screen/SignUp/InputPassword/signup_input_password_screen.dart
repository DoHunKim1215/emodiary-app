import 'package:emodiary/screen/SignUp/InputPassword/Widget/validate_password_confirm_row.dart';
import 'package:emodiary/screen/SignUp/InputPassword/Widget/validate_password_row.dart';
import 'package:emodiary/widget/base/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpInputPasswordScreen extends StatefulWidget {
  final void Function() onTapNext;

  const SignUpInputPasswordScreen({
    super.key,
    required this.onTapNext,
  });

  @override
  State<SignUpInputPasswordScreen> createState() =>
      _SignUpInputPasswordScreenState();
}

class _SignUpInputPasswordScreenState extends State<SignUpInputPasswordScreen> {
  static const int passwordMaxLength = 100;

  late TextEditingController _passwordCtrl;
  late TextEditingController _passwordConfirmCtrl;

  @override
  void initState() {
    super.initState();
    _passwordCtrl = TextEditingController();
    _passwordConfirmCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _passwordConfirmCtrl.dispose();
    super.dispose();
  }

  bool canSend() {
    return _passwordCtrl.text.isNotEmpty &&
        _passwordConfirmCtrl.text.isNotEmpty &&
        _passwordCtrl.text == _passwordConfirmCtrl.text &&
        _passwordCtrl.text.contains(RegExp(r'[a-zA-Z]')) &&
        _passwordCtrl.text.contains(RegExp(r'[0-9]')) &&
        _passwordCtrl.text
            .contains(RegExp(r"[~!@#$%^&*()_+\-=\[\]{};:\\|,.<>/?]")) &&
        _passwordCtrl.text.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "로그인에 사용할\n비밀번호를 입력해주세요.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                height: 76,
              ),
              const Text(
                "비밀번호 입력",
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
                maxLength: passwordMaxLength,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '영문, 숫자, 특수문자 조합 8자리 이상',
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
                height: 13,
              ),
              ValidatePasswordRow(controller: _passwordCtrl),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "비밀번호 확인",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              TextField(
                controller: _passwordConfirmCtrl,
                onChanged: (_) {
                  setState(() {});
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                maxLength: passwordMaxLength,
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
                    onTap: _passwordConfirmCtrl.clear,
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
                height: 13,
              ),
              ValidatePasswordConfirmRow(
                passwordCtrl: _passwordCtrl,
                passwordConfirmCtrl: _passwordConfirmCtrl,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CommonBottomButton(
                  text: "다음",
                  disabledText: "닉네임과 휴대폰 번호를 입력해주세요!",
                  onPressed: canSend() ? widget.onTapNext : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
