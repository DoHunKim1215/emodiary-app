enum ESignUpProcess {
  terms,
  identify,
  inputId,
  inputPassword;

  // static void Function()? back(int routeIndex, BuildContext context) {
  //   var routeItem = LoginRoute.values[routeIndex];
  //
  //   switch (routeItem) {
  //     case LoginRoute.terms:
  //       return () {
  //         showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
  //           builder: (BuildContext context) {
  //             return NotRouteBackConfirmDialog(
  //               question: "다시 로그인하시겠습니까?",
  //               backAction: () {
  //                 Get.offAllNamed("/login");
  //               },
  //             );
  //           },
  //         );
  //       };
  //     case LoginRoute.identifyEntry:
  //       return () {
  //         final routeController = Get.put(LoginRouteController());
  //         routeController.goto(LoginRoute.terms);
  //       };
  //     case LoginRoute.identifyResult:
  //       return () {
  //         showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
  //           builder: (BuildContext context) {
  //             return NotRouteBackConfirmDialog(
  //               question: "본인인증을 다시 하시겠습니까?",
  //               backAction: () {
  //                 final routeController = Get.put(LoginRouteController());
  //                 routeController.goto(LoginRoute.identifyEntry);
  //               },
  //             );
  //           },
  //         );
  //       };
  //     case LoginRoute.nicknameInput:
  //       return () {
  //         showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
  //           builder: (BuildContext context) {
  //             return NotRouteBackConfirmDialog(
  //               question: "본인인증을 다시 하시겠습니까?",
  //               backAction: () {
  //                 final routeController = Get.put(LoginRouteController());
  //                 routeController.goto(LoginRoute.identifyEntry);
  //               },
  //             );
  //           },
  //         );
  //       };
  //     case LoginRoute.modeSelection:
  //       return () {
  //         final routeController = Get.put(LoginRouteController());
  //         routeController.goto(LoginRoute.nicknameInput);
  //       };
  //     case LoginRoute.finish:
  //       return null;
  //     default:
  //       assert(false, "🚨 [Assertion Error] Invalid Login Route Enum Value.");
  //   }
  //   return () {};
  // }

  // Widget get screen {
  //   switch (this) {
  //     case LoginRoute.terms:
  //       return const LoginTermsScreen();
  //     case LoginRoute.identify:
  //       return IdentificationEntryScreen();
  //     case LoginRoute.inputId:
  //       return IdentificationResultScreen();
  //     case LoginRoute.inputPassword:
  //       return NicknameInputScreen();
  //     default:
  //       assert(false, "🚨 [Assertion Error] Invalid Login Route Enum Value.");
  //   }
  //   return Container();
  // }
}
