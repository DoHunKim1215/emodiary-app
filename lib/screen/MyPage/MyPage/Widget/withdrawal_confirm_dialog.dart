import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WithdrawalConfirmDialog extends StatefulWidget {
  const WithdrawalConfirmDialog({super.key});

  @override
  State<WithdrawalConfirmDialog> createState() =>
      _WithdrawalConfirmDialogState();
}

class _WithdrawalConfirmDialogState extends State<WithdrawalConfirmDialog> {
  bool isAllowed = false;

  void onTapConsent() {
    setState(() {
      isAllowed = !isAllowed;
    });
  }

  void onTapConfirm() {
    Get.back();
    logOnDev("Confirm");
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 34.0,
            vertical: 24.0,
          ),
          width: MediaQuery.of(context).size.width - 48.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "탈퇴하기",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "탈퇴하면 현재 계정으로 작성한\n모든 일기와 그림, 감정 등을 수정하거나\n삭제할 수 없습니다.\n지금 탈퇴하시겠습니까?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF656D78),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: onTapConsent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isAllowed
                        ? Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/uncheck-icon.svg",
                                width: 20,
                                height: 20,
                              ),
                              SvgPicture.asset(
                                "assets/icons/check.svg",
                                width: 16,
                                height: 16,
                              ),
                            ],
                          )
                        : SvgPicture.asset(
                            "assets/icons/unchecked-ellipse.svg",
                            width: 20,
                            height: 20,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "동의합니다",
                      style: TextStyle(
                        color: Color(0xFF656D78),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        backgroundColor: const Color(0xFFF5F7FA),
                        foregroundColor: const Color(0xFF7541EF),
                        splashFactory: NoSplash.splashFactory,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text(
                        "취소",
                        style: TextStyle(
                          color: Color(0xFF7541EF),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          height: 1.44,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: isAllowed ? onTapConfirm : null,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        backgroundColor: isAllowed
                            ? const Color(0xFF7541EF)
                            : const Color(0xFFF5F7FA),
                        foregroundColor: const Color(0xFF7541EF),
                        splashFactory: NoSplash.splashFactory,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(
                          color: isAllowed
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFAAB2BD),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                    ),
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
