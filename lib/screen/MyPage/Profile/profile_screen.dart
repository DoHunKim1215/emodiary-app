import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/widget/MyPage/mypage_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int nameMaxLength = 10;

  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: "홍길동");
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
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
            child: MyPageAppBar(
              title: "프로필",
              onPressedLeading: () {
                Get.back();
              },
              onPressedAction: () {
                logOnDev("SAVE!");
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                SvgPicture.asset(
                  "assets/icons/profile.svg",
                  width: 76,
                  height: 76,
                ),
                const SizedBox(
                  height: 14,
                ),
                TextButton(
                  onPressed: () {
                    logOnDev("Update Profile Image");
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F7FA),
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "프로필 사진 업데이트",
                    style: TextStyle(
                      color: Color(0xFF787A93),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text(
                          "이름",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _nameCtrl,
                          onChanged: (_) {
                            setState(() {});
                          },
                          maxLength: nameMaxLength,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          decoration: const InputDecoration(
                            counterText: "",
                            isDense: true,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
