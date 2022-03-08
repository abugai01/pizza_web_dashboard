import 'package:pizza_web_dashboard/routing/routes.dart';

const overviewPageDisplayName = "Overview";
const usersPageDisplayName = "Users";
const ordersPageDisplayName = "Orders";
const servicesPageDisplayName = "Услуги и цены";
const statsPageDisplayName = 'Stats';
const paymentsPageDisplayName = 'Payments';
const additionalPageDisplayName = 'Additional';
const authPageDisplayName = "Sign Out";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  //MenuItem(overviewPageDisplayName, overviewPageRoute), //TODO: сделать и вернуть!
  MenuItem(usersPageDisplayName, usersPageRoute),
  MenuItem(ordersPageDisplayName, ordersPageRoute),
  MenuItem(statsPageDisplayName, statsPageRoute),
  MenuItem(paymentsPageDisplayName, paymentsPageRoute),
  MenuItem(additionalPageDisplayName, additionalPageRoute),
  MenuItem(authPageDisplayName, authPageRoute),
];
