import 'package:emodiary/screen/MyPage/MyPage/Widget/mypage_menu_row.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/widget/MyPage/mypage_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

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
              title: "마이페이지",
              onPressedLeading: () {
                logOnDev("BACK!");
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "홍길동",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      "님",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Container(
                    height: 1.0,
                    color: const Color(0xFFE6E9ED),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyPageMenuRow(
                      title: "프로필 수정",
                      onPressed: () {
                        logOnDev("Profile");
                      },
                    ),
                    MyPageMenuRow(
                      title: "계정 관리",
                      followingText: "카카오",
                      onPressed: () {
                        logOnDev("Account Management");
                      },
                    ),
                    MyPageMenuRow(
                      title: "알림 설정",
                      onPressed: () {
                        logOnDev("Alert Setting");
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Container(
                        height: 1.0,
                        color: const Color(0xFFE6E9ED),
                      ),
                    ),
                    MyPageMenuRow(
                      title: "공지 사항",
                      onPressed: () {
                        logOnDev("Notice");
                      },
                    ),
                    MyPageMenuRow(
                      title: "고객센터",
                      onPressed: () {
                        logOnDev("Customer Service");
                      },
                    ),
                    MyPageMenuRow(
                      title: "이용약관",
                      onPressed: () {
                        logOnDev("Terms");
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "버전",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "1.0.0",
                                style: TextStyle(
                                  color: Color(0xFF7541EF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "최신 버전입니다.",
                            style: TextStyle(
                              color: Color(0xFF878786),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Container(
                        height: 1.0,
                        color: const Color(0xFFE6E9ED),
                      ),
                    ),
                    MyPageMenuRow(
                      title: "로그아웃",
                      titleColor: const Color(0xFFEB4E3D),
                      onPressed: () {
                        logOnDev("Logout");
                      },
                    ),
                    MyPageMenuRow(
                      title: "회원 탈퇴",
                      titleColor: const Color(0xFF878786),
                      onPressed: () {
                        logOnDev("Delete Account");
                      },
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
