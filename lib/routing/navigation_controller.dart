import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
//
// class NavigationController extends GetxController {
//   static NavigationController instance = Get.find();
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
//
//   Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
//     return navigatorKey.currentState!
//         .pushNamed(routeName, arguments: arguments);
//   }
//
//   goBack() => navigatorKey.currentState!.pop();
// }

//TODO: можно заюзать здесь RouterHelper
class NavigationController {
  // NavigationController._privateConstructor();
  // static final NavigationController _instance =
  //     NavigationController._privateConstructor();
  // static NavigationController get instance => _instance;
  //
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
  //   return navigatorKey.currentState!
  //       .pushNamed(routeName, arguments: arguments);
  // }

  // goBack() => navigatorKey.currentState!.pop();

  static navigateTo(BuildContext context, {required String route}) {
    //Чтобы не пропадал / в начале
    String _route = '/' + route;

    Navigator.of(context).pushNamed(_route);
  }

  // static navigateToWithId(BuildContext context,
  //     {required String route, required String id}) {
  //   String _route = '/' + route + '/' + id;
  //
  //   Navigator.of(context).pushNamed(_route);
  // }

  // static navigateToWithRouteList(BuildContext context,
  //     {required List<String> routeList}) {
  //   String _route = '/' + convertListToString(routeList, separator: '/');
  //
  //   Navigator.of(context).pushNamed(_route);
  // }
}
