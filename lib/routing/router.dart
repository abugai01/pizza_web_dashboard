import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/pages/404/error.dart';
import 'package:pizza_web_dashboard/pages/additional/additional_page.dart';
import 'package:pizza_web_dashboard/pages/authentication/authentication.dart';
import 'package:pizza_web_dashboard/pages/home_page.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/order_individual_page.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/user_individual_page.dart';
import 'package:pizza_web_dashboard/pages/orders/orders_page.dart';
import 'package:pizza_web_dashboard/pages/overview/overview.dart';
import 'package:pizza_web_dashboard/pages/payments/payments_page.dart';
import 'package:pizza_web_dashboard/pages/stats/stats_page.dart';
import 'package:pizza_web_dashboard/pages/users/users_page.dart';
import 'package:pizza_web_dashboard/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Handle '/'
  if (settings.name == rootRoute) {
    return _getPageRoute(HomePage(), settings: settings);
  }

  // Handle '/details/:id'
  var uri = Uri.parse(settings.name!);

  // print("URI: ${uri.toString()}");
  // print("URI PATH SEGMENTS FIRST: ${uri.pathSegments.first}");
  // print(uri.pathSegments.length >= 2
  //     ? "URI PATH SEGMENTS SECOND: ${uri.pathSegments[1]}"
  //     : "\n");

  if (uri.pathSegments.length == 1) {
    switch (uri.pathSegments.first) {
      case overviewPageRoute:
        return _getPageRoute(OverviewPage(), settings: settings);
      case usersPageRoute:
        return _getPageRoute(UsersPage(), settings: settings);
      case ordersPageRoute:
        return _getPageRoute(OrdersPage(), settings: settings);
      case statsPageRoute:
        return _getPageRoute(StatsPage(), settings: settings);
      case paymentsPageRoute:
        return _getPageRoute(PaymentsPage(), settings: settings);
      case additionalPageRoute:
        return _getPageRoute(AdditionalPage(), settings: settings);
      case authPageRoute:
        return _getPageRoute(AuthenticationPage(), settings: settings);
      // default:
      //   return _getPageRoute(PageNotFound(), settings: settings);
    }
  } else if (uri.pathSegments.length == 2) {
    switch (uri.pathSegments.first) {
      case userIndividualPageRoute:
        return _getPageRoute(UserIndividualPage(userId: uri.pathSegments[1]),
            settings: settings);
      case orderIndividualPageRoute:
        return _getPageRoute(OrderIndividualPage(orderId: uri.pathSegments[1]),
            settings: settings);
    }
  }
  return _getPageRoute(PageNotFound(), settings: settings);
}

PageRoute _getPageRoute(Widget child, {RouteSettings? settings}) {
  //return MaterialPageRoute(builder: (context) => child, settings: settings);
  return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child, settings: settings);
}
