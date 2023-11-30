import 'package:emodiary/repository/home/home_repository.dart';
import 'package:emodiary/widget/calendar/image_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/home/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = Get.put(HomeViewModel(
      repository: HomeRepository(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFCEB9FF),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ImageCalendar(viewModel: _viewModel),
            ),
          ],
        ));
  }
}
