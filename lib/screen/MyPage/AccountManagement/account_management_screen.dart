import 'package:emodiary/screen/MyPage/AccountManagement/Widget/synced_account_container.dart';
import 'package:emodiary/screen/MyPage/AccountManagement/Widget/user_information_row.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/widget/MyPage/mypage_appbar.dart';
import 'package:flutter/material.dart';

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({super.key});

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
              title: "계정 관리",
              onPressedLeading: () {
                logOnDev("BACK!");
              },
            ),
          ),
          body: Column(
            children: [
              const SyncedAccountContainer(),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "회원 정보",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UserInformationRow(title: "성명", content: "홍길동"),
                    SizedBox(
                      height: 14,
                    ),
                    UserInformationRow(title: "연락처", content: "010-1234-6789"),
                    SizedBox(
                      height: 14,
                    ),
                    UserInformationRow(title: "생일", content: "2023. 01. 01."),
                    SizedBox(
                      height: 14,
                    ),
                    UserInformationRow(title: "성별", content: "남"),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  logOnDev("Update User Info");
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
                  "본인인증으로 정보 수정하기",
                  style: TextStyle(
                    color: Color(0xFF787A93),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
