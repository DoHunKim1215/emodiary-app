import 'package:cached_network_image/cached_network_image.dart';
import 'package:emodiary/util/class/tel_formatter.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/viewModel/MyPage/user_view_model.dart';
import 'package:emodiary/widget/MyPage/mypage_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel());

  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int nameMaxLength = 10;
  static const int telMaxLength = 13;

  late TextEditingController _nameCtrl;
  late TextEditingController _telCtrl;

  bool isEditMode = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final userModel = widget.userViewModel.userModel.value!;
    _nameCtrl = TextEditingController(text: userModel.nickname);
    _telCtrl = TextEditingController(text: userModel.phoneNumber);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _telCtrl.dispose();
    super.dispose();
  }

  void onPressEdit() {
    setState(() {
      isEditMode = true;
    });
  }

  void onPressSave() {
    setState(() {
      isEditMode = false;
    });
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
              actionText: isEditMode ? "저장" : "수정",
              onPressedLeading: isLoading ? () {} : Get.back,
              onPressedAction: isLoading
                  ? () {}
                  : isEditMode
                      ? onPressSave
                      : onPressEdit,
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
                        '${dotenv.env["SERVER_HOST"]}/images/${widget.userViewModel.userModel.value!.profileImageUrl}',
                    width: 76,
                    height: 76,
                  ),
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
                  children: [
                    Row(
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
                            readOnly: !isEditMode || isLoading,
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
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            "연락처",
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
                            readOnly: !isEditMode || isLoading,
                            controller: _telCtrl,
                            inputFormatters: [
                              TelFormatter(
                                masks: ["xxx-xxxx-xxxx"],
                                separator: "-",
                              ),
                            ],
                            onChanged: (_) {
                              setState(() {});
                            },
                            maxLength: telMaxLength,
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
                  ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
