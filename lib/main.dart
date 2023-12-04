import 'package:emodiary/screen/Diary/Search/diary_search_screen.dart';
import 'package:emodiary/screen/Diary/diary_calendar_screen.dart';
import 'package:emodiary/screen/Diary/Read/diary_read_screen.dart';
import 'package:emodiary/screen/Login/login_screen.dart';
import 'package:emodiary/screen/MyPage/AccountManagement/account_management_screen.dart';
import 'package:emodiary/screen/MyPage/MyPage/mypage_screen.dart';
import 'package:emodiary/screen/MyPage/Profile/profile_screen.dart';
import 'package:emodiary/screen/SignUp/Entry/signup_entry_screen.dart';
import 'package:emodiary/screen/SignUp/Process/signup_process_screen.dart';
import 'package:emodiary/screen/Writing/Loading/diary_writing_loading_screen.dart';
import 'package:emodiary/screen/Writing/Saved/diary_writing_save_screen.dart';
import 'package:emodiary/screen/Writing/SelectPicture/diary_writing_select_picture_screen.dart';
import 'package:emodiary/screen/Writing/Writing/diary_writing_screen.dart';
import 'package:emodiary/screen/root_screen.dart';
import 'package:emodiary/util/function/get_initial_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  /* Open .env file */
  await dotenv.load(fileName: "assets/config/.env");

  final initialRoute = await getInitialRoute();

  initializeDateFormatting()
      .then((_) => runApp(MyApp(initialRoute: initialRoute)));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({
    super.key,
    required this.initialRoute,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    return GetMaterialApp(
      title: "Emodiary",
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
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => const RootScreen()),
        GetPage(name: "/entry", page: () => const SignUpEntryScreen()),
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/signup", page: () => SignUpProcessScreen()),
        GetPage(name: "/mypage", page: () => const MyPageScreen()),
        GetPage(name: "/mypage/profile", page: () => ProfileScreen()),
        GetPage(
          name: "/mypage/account",
          page: () => const AccountManagementScreen(),
        ),
        GetPage(name: "/writing", page: () => const DiaryWritingScreen()),
        GetPage(
          name: "/diary",
          page: () => const DiaryReadScreen(),
          children: [
            GetPage(name: "/calendar", page: () => const DiaryCalendarScreen()),
            GetPage(name: "/search", page: () => const DiarySearchScreen()),
            GetPage(
              name: "/writing",
              page: () => const DiaryWritingScreen(),
              children: [
                GetPage(
                  name: "/loading",
                  page: () => const DiaryWritingLoadingScreen(),
                ),
                GetPage(
                  name: "/select",
                  page: () => const DiaryWritingSelectPictureScreen(),
                ),
                GetPage(
                  name: "/save",
                  page: () => DiaryWritingSaveScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
