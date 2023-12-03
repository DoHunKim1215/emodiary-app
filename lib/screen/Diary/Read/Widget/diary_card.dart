import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emodiary/viewModel/Diary/diary_read_view_model.dart';
import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DiaryCard extends StatelessWidget {
  final DiaryReadViewModel viewModel;
  final bool isShownPicture;

  const DiaryCard({
    super.key,
    required this.viewModel,
    required this.isShownPicture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 66.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFF1F0F5),
        ),
        color: const Color.fromRGBO(254, 250, 255, 0.80),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => SizedBox(
                height: 440,
                child: isShownPicture
                    ? Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                placeholder: (context, url) {
                                  return Container();
                                },
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                                imageUrl:
                                    '${dotenv.env["SERVER_HOST"]}/images/${viewModel.getImageUrl()}',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: viewModel.getTitle(),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: DiaryWritingViewModel.titleMaxLength,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              counterText: "",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 0.0,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFFD66C),
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFFD66C),
                                  width: 3.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Stack(
                        children: [
                          for (int i = 0; i < 10; i++)
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                top: 8 + (i + 1) * 40,
                              ),
                              height: 2,
                              color: const Color(0xFFF1F0F5),
                            ),
                          SingleChildScrollView(
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: viewModel.getContent(),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 2.5,
                              ),
                              cursorColor: const Color(0xFF787A93),
                              decoration: const InputDecoration(
                                counterText: "",
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
