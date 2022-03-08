// import 'package:flutter/material.dart';
//
// void changeScreen(BuildContext context, Widget widget) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
// }
//
// // request here
// void changeScreenReplacement(BuildContext context, Widget widget) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
// }
//
// void changeScreenWithoutAnimation(BuildContext context, Widget widget) {
//   Navigator.pushReplacement(
//     context,
//     PageRouteBuilder(
//       pageBuilder: (context, _, __) => widget,
//       transitionDuration: Duration(seconds: 0),
//     ),
//   );
// }

//TODO: null safety?
// class NavigationService {
//   GlobalKey<NavigatorState> navigatorKey;
//
//   static NavigationService instance = NavigationService();
//
//   NavigationService() : navigatorKey = GlobalKey<NavigatorState>();
//
//   Future<dynamic> navigateToReplacement(String _rn) {
//     return navigatorKey.currentState!.pushReplacementNamed(_rn);
//   }
//
//   Future<dynamic> navigateTo(String _rn) {
//     return navigatorKey.currentState!.pushNamed(_rn);
//   }
//
//   Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
//     return navigatorKey.currentState!.push(_rn);
//   }
//
//   goBack() {
//     return navigatorKey.currentState!.pop();
//   }
// }
