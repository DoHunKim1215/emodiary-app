import 'package:emodiary/screen/Diary/Loading/diary_writing_loading_screen.dart';
import 'package:emodiary/screen/Diary/SelectPicture/diary_writing_select_picture_screen.dart';
import 'package:emodiary/screen/Diary/Writing/diary_writing_screen.dart';
import 'package:emodiary/screen/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    return GetMaterialApp(
      title: "JJoin",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: "/writing/select",
      getPages: [
        GetPage(name: '/', page: () => const RootScreen()),
        GetPage(name: "/writing", page: () => const DiaryWritingScreen()),
        GetPage(
          name: "/writing/loading",
          page: () => const DiaryWritingLoadingScreen(),
        ),
        GetPage(
          name: "/writing/select",
          page: () => const DiaryWritingSelectPictureScreen(),
        ),
      ],
    );
  }
}
