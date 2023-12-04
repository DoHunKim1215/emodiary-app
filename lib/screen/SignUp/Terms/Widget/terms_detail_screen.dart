import 'package:emodiary/widget/base/leading_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsDetailScreen extends StatelessWidget {
  const TermsDetailScreen({super.key});

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
            child: LeadingAppBar(
              title: "약관",
              onPressed: Get.back,
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              // child: FutureBuilder<String>(
              //   future: loginTermsProvider.loadAsset(terms),
              //   builder: (context, snapshot) {
              //     if (!snapshot.hasData && !snapshot.hasError) {
              //       return const CircularProgressIndicator();
              //     }
              //
              //     return Text(
              //       snapshot.data!,
              //       style: TermsDetailStyle.content,
              //     );
              //   },
              // ),
              child: Text(
                "약관 내용",
                style: TextStyle(
                  color: Color(0xFF464655),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
