import 'package:pizza_web_dashboard/routing/routes.dart';

const overviewPageDisplayName = "Главная";
const usersPageDisplayName = "Пользователи";
const executorsPageDisplayName = "Исполнители";
const ordersPageDisplayName = "Заказы";
const servicesPageDisplayName = "Услуги и цены";
const mapPageDisplayName = 'Карта';
const statsPageDisplayName = 'Статистика';
const paymentsPageDisplayName = 'Платежи';
const additionalPageDisplayName = 'Дополнительно';
const authPageDisplayName = "Выход";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  //MenuItem(overviewPageDisplayName, overviewPageRoute), //TODO: сделать и вернуть!
  MenuItem(usersPageDisplayName, usersPageRoute),
  MenuItem(executorsPageDisplayName, executorsPageRoute),
  MenuItem(ordersPageDisplayName, ordersPageRoute),
  MenuItem(servicesPageDisplayName, servicesPageRoute),
  MenuItem(mapPageDisplayName, mapPageRoute),
  MenuItem(statsPageDisplayName, statsPageRoute),
  MenuItem(paymentsPageDisplayName, paymentsPageRoute),
  MenuItem(additionalPageDisplayName, additionalPageRoute),
  MenuItem(authPageDisplayName, authPageRoute),
];
