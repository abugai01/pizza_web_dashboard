import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/routing/controllers.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/helpers/responsiveness.dart';
import 'package:pizza_web_dashboard/routing/menu_items.dart';
import 'package:pizza_web_dashboard/routing/routes.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:pizza_web_dashboard/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dashboard",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (item.route == authPageRoute) {
                        //Get.offAllNamed(authenticationPageRoute);
                        //Navigator.pushNamed(context, authenticationPageRoute);
                        // NavigationController.instance
                        //     .navigateTo(authenticationPageRoute);
                        Navigator.of(context).pushNamed(authPageRoute);
                        menuController
                            .changeActiveItemTo(overviewPageDisplayName);
                      }
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        //if (ResponsiveWidget.isSmallScreen(context)) //Get.back(); //TODO: разобраться с этим или вообще выпилить responsiveness
                        //navigationController.navigateTo(item.route);

                        //Navigator.of(context).pushNamed(item.route);
                        NavigationController.navigateTo(context,
                            route: item.route);
                        //NavigationController.instance.navigateTo(item.route);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
