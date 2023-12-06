import 'package:emodiary/screen/MyPage/MyPage/Widget/mypage_has_data_screen.dart';
import 'package:emodiary/screen/MyPage/MyPage/Widget/mypage_has_not_data_screen.dart';
import 'package:emodiary/viewModel/MyPage/user_view_model.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  final UserViewModel userViewModel;

  const MyPageScreen({
    super.key,
    required this.userViewModel,
  });

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  bool isLoading = false;

  void getUserInfo() {
    setState(() {
      isLoading = true;
    });

    widget.userViewModel.getUserInfo().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : widget.userViewModel.userModel.value == null
                  ? MyPageHasNotDataScreen(onPressRetry: getUserInfo)
                  : MyPageHasDataScreen(userViewModel: widget.userViewModel),
        ),
      ),
    );
  }
}
