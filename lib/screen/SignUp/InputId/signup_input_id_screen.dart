import 'package:emodiary/viewModel/SignUp/signup_view_model.dart';
import 'package:emodiary/widget/base/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpInputIdScreen extends StatefulWidget {
  final void Function() gotoNext;
  final SignUpViewModel viewModel;

  const SignUpInputIdScreen({
    super.key,
    required this.gotoNext,
    required this.viewModel,
  });

  @override
  State<SignUpInputIdScreen> createState() => _SignUpInputIdScreenState();
}

class _SignUpInputIdScreenState extends State<SignUpInputIdScreen> {
  static const int idMinLength = 4;
  static const int idMaxLength = 20;

  late TextEditingController _idCtrl;

  @override
  void initState() {
    super.initState();
    _idCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    super.dispose();
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
                "로그인에 사용할\n아이디를 입력해주세요.",
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
                maxLength: idMaxLength,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '아이디 입력 (4~20자)',
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
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CommonBottomButton(
                  text: "다음",
                  disabledText: "아이디를 입력해주세요!",
                  onPressed: _idCtrl.text.length >= idMinLength
                      ? () {
                          widget.viewModel.setSerialID(_idCtrl.text);
                          widget.gotoNext();
                        }
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
