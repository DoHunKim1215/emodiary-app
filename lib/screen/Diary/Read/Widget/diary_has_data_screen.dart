import 'package:emodiary/provider/Diary/shared_diary_provider.dart';
import 'package:emodiary/screen/Diary/Read/Widget/diary_back_card.dart';
import 'package:emodiary/screen/Diary/Read/Widget/diary_card.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/viewModel/Diary/diary_read_view_model.dart';
import 'package:emodiary/viewModel/MyPage/user_view_model.dart';
import 'package:emodiary/widget/Writing/diary_confirm_dialog.dart';
import 'package:emodiary/widget/Writing/diary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class DiaryHasDataScreen extends StatefulWidget {
  final DiaryReadViewModel diaryReadViewModel;

  const DiaryHasDataScreen({
    super.key,
    required this.diaryReadViewModel,
  });

  @override
  State<DiaryHasDataScreen> createState() => _DiaryHasDataScreenState();
}

class _DiaryHasDataScreenState extends State<DiaryHasDataScreen> {
  final UserViewModel userViewModel = Get.find<UserViewModel>();
  final SharedDiaryProvider sharedDiaryProvider = SharedDiaryProvider();

  bool isShownPicture = true;
  bool isLoading = false;

  void flipCard() {
    setState(() {
      isShownPicture = !isShownPicture;
    });
  }

  void onTapDelete() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기를 정말 삭제하시겠습니까?",
          cancel: "취소",
          confirm: "삭제하기",
          cancelAction: () {
            Get.back();
          },
          confirmAction: () {
            setState(() {
              isLoading = true;
            });

            widget.diaryReadViewModel
                .deleteDiary(widget.diaryReadViewModel.diaryModel.value!.id)
                .then((value) {
              setState(() {
                isLoading = false;
              });
              Get.back();
            }).onError((error, stackTrace) {
              setState(() {
                isLoading = false;
              });
              Get.snackbar(
                '일기를 삭제하는데 실패했습니다.',
                '알 수 없는 이유로 일기 삭제에 실패했습니다.',
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                duration: const Duration(milliseconds: 1500),
                snackPosition: SnackPosition.TOP,
                backgroundColor: const Color(0xFFF5F5F9),
                colorText: Colors.black,
              );
            });
          },
        );
      },
    );
  }

  void onPressShare() {
    setState(() {
      isLoading = true;
    });

    if (userViewModel.userModel.value == null) {
      Get.snackbar(
        "일기를 공유하는데 실패했습니다.",
        '사용자님의 정보를 불러올 수 없습니다.',
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF5F5F9),
        colorText: Colors.black,
      );
      return;
    }

    sharedDiaryProvider
        .shareDiary(widget.diaryReadViewModel.diaryModel.value!.id)
        .then(
      (value) {
        setState(() {
          isLoading = false;
        });

        logOnDev(
          "🎉 [Diary Share Successes] UUID : ${value.uuid} | Auth Code : ${value.authCode}",
        );

        Share.share(
          "[Emodiary]\n"
          "${userViewModel.userModel.value!.nickname}님이 "
          "${DateFormat("yyyy년 MM월 dd일").format(widget.diaryReadViewModel.diaryModel.value!.whichDate)} 일기를 공유했어요!\n"
          "링크 : ${dotenv.env["WEB_HOST"]}/diary/${value.uuid}\n"
          "보안 코드 : ${value.authCode}\n"
          "유효 기간 : 하루 (24시간)",
        );
      },
    ).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });

      Get.snackbar(
        "일기를 공유하는데 실패했습니다.",
        '방금 공유한 일기인지 확인해보세요!',
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF5F5F9),
        colorText: Colors.black,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: DiaryAppBar(
          title: DateFormat("yyyy년 MM월 dd일")
              .format(widget.diaryReadViewModel.diaryModel.value!.whichDate),
          onPressedLeading: isLoading ? null : Get.back,
          onPressedAction: isLoading ? null : onPressShare,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const DiaryBackCard(),
                DiaryCard(
                  viewModel: widget.diaryReadViewModel,
                  isShownPicture: isShownPicture,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                  ),
                  onPressed: flipCard,
                  icon: SvgPicture.asset(
                    "assets/icons/rotate-button-icon.svg",
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: isLoading ? null : onTapDelete,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: const Color(0xFFED5565),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/bin.svg",
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFFFABB5),
                          BlendMode.srcIn,
                        ),
                        width: 34,
                        height: 34,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
