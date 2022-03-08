import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/widgets/side_menu.dart';

import 'widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final Widget child;

  SiteLayout({required this.child});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey,
          username: "Administrator"), //TODO: сделать
      drawer: Drawer(
        child: SideMenu(),
      ),
      // body: ResponsiveWidget(
      //     largeScreen: LargeScreen(),
      //     smallScreen: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16),
      //       child: localNavigator(),
      //     )),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SideMenu()),
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              // child: Navigator(
              //   key: NavigationController.instance.navigatorKey,
              //   onGenerateRoute: generateRoute,
              //   initialRoute: overviewPageRoute,
              // ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
