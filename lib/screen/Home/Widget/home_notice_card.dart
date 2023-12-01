import 'package:emodiary/viewModel/home/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeNoticeCard extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeNoticeCard({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<HomeNoticeCard> createState() => _HomeNoticeCardState();
}

class _HomeNoticeCardState extends State<HomeNoticeCard> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      width: MediaQuery.of(context).size.width - 40,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Text(
            "공지",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text("2021년 12월 14일부터 일기를 작성할 수 있습..."),
        ],
      ),
    );
  }
}
