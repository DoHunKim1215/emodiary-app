import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignOutConfirmDialog extends StatelessWidget {
  final void Function() onPressConfirm;

  const SignOutConfirmDialog({
    super.key,
    required this.onPressConfirm,
  });

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
                "로그아웃하시겠습니까?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
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
                      onPressed: onPressConfirm,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        backgroundColor: const Color(0xFF7541EF),
                        foregroundColor: const Color(0xFF7541EF),
                        splashFactory: NoSplash.splashFactory,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text(
                        "확인",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
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
