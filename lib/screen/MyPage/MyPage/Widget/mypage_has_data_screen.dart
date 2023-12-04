import 'package:cached_network_image/cached_network_image.dart';
import 'package:emodiary/screen/MyPage/MyPage/Widget/mypage_menu_row.dart';
import 'package:emodiary/screen/MyPage/MyPage/Widget/signout_confirm_dialog.dart';
import 'package:emodiary/screen/MyPage/MyPage/Widget/withdrawal_confirm_dialog.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/viewModel/MyPage/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyPageHasDataScreen extends StatefulWidget {
  final UserViewModel userViewModel;

  const MyPageHasDataScreen({
    super.key,
    required this.userViewModel,
  });

  @override
  State<MyPageHasDataScreen> createState() => _MyPageHasDataScreenState();
}

class _MyPageHasDataScreenState extends State<MyPageHasDataScreen> {
  bool isLoading = false;

  void onTapSignOut() {
    setState(() {
      isLoading = true;
    });

    widget.userViewModel.signOut().then((isSuccess) {
      setState(() {
        isLoading = false;
      });

      if (isSuccess) {
        Get.snackbar(
          '로그아웃 성공',
          '성공적으로 로그아웃되었습니다.',
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          duration: const Duration(milliseconds: 1500),
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF5F5F9),
          colorText: Colors.black,
        );
        Get.offAllNamed("/entry");
      } else {
        Get.snackbar(
          '로그아웃 실패',
          '로그아웃에 실패했습니다.',
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          duration: const Duration(milliseconds: 1500),
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF5F5F9),
          colorText: Colors.black,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userModel = widget.userViewModel.userModel.value!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(38.0),
            child: CachedNetworkImage(
              placeholder: (context, url) {
                return SvgPicture.asset(
                  "assets/icons/profile.svg",
                  width: 76,
                  height: 76,
                );
              },
              errorWidget: (context, url, error) {
                return SvgPicture.asset(
                  "assets/icons/profile.svg",
                  width: 76,
                  height: 76,
                );
              },
              imageUrl:
                  '${dotenv.env["SERVER_HOST"]}/images/${userModel.profileImageUrl}',
              width: 76,
              height: 76,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userModel.nickname,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const Text(
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
                onPressed: isLoading
                    ? null
                    : () {
                        Get.toNamed("/mypage/profile");
                      },
              ),
              MyPageMenuRow(
                title: "계정 관리",
                followingText: userModel.loginProvider.displayName,
                onPressed: isLoading
                    ? null
                    : () {
                        Get.toNamed("/mypage/account");
                      },
              ),
              MyPageMenuRow(
                title: "알림 설정",
                onPressed: isLoading
                    ? null
                    : () {
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
                onPressed: isLoading
                    ? null
                    : () {
                        logOnDev("Notice");
                      },
              ),
              MyPageMenuRow(
                title: "고객센터",
                onPressed: isLoading
                    ? null
                    : () {
                        logOnDev("Customer Service");
                      },
              ),
              MyPageMenuRow(
                title: "이용약관",
                onPressed: isLoading
                    ? null
                    : () {
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
                onPressed: isLoading
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: const Color.fromRGBO(0, 0, 0, 0.3),
                          builder: (BuildContext context) {
                            return SignOutConfirmDialog(
                              onPressConfirm: onTapSignOut,
                            );
                          },
                        );
                      },
              ),
              MyPageMenuRow(
                title: "회원 탈퇴",
                titleColor: const Color(0xFF878786),
                onPressed: isLoading
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: const Color.fromRGBO(0, 0, 0, 0.3),
                          builder: (BuildContext context) {
                            return const WithdrawalConfirmDialog();
                          },
                        );
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
