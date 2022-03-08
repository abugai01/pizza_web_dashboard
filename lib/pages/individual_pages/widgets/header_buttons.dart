import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';

class HeaderButtons extends StatelessWidget {
  final String? id;
  final List<Routes> _routes;

  HeaderButtons({this.id, List<Routes>? routes}) : _routes = routes ?? [];

  @override
  Widget build(BuildContext context) {
    if (_routes.length == 0) {
      return Container();
    } else {
      return Row(
        children: _buildButtons(context, routes: _routes, id: id),
      );
    }
  }

  List<Widget> _buildButtons(BuildContext context,
      {required List<Routes> routes, required String? id}) {
    List<Widget> res = [];

    for (int i = 0; i < routes.length; i++) {
      res.add(HeaderButton(
        icon: getIcon(routes[i]),
        function: () {
          NavigationController.navigateTo(context,
              route: RouteGenerator.genLink(routes[i], id: id));
        },
      ));
    }

    return res;
  }

  IconData getIcon(Routes route) {
    switch (route) {
      case Routes.userAddresses:
        return Icons.apartment_outlined;
      case Routes.userPets:
        return Icons.pets;
      case Routes.orderMap:
        return Icons.map_outlined;
      case Routes.executorReviews:
        return Icons.grade_outlined;
      case Routes.executorsPayments:
        return Icons.attach_money_outlined;
      case Routes.executorsUnallowed:
        return Icons.do_disturb_alt_outlined;

      default:
        return Icons.help_outline_outlined;
    }
  }
}

class HeaderButton extends StatelessWidget {
  final Function? function;
  final String? heroTag;
  final IconData icon;

  const HeaderButton({this.function, required this.icon, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: FloatingActionButton(
        onPressed: () {
          if (function != null) return function!();
        },
        heroTag: heroTag ?? Uuid().v1(),
        child: Icon(icon),
      ),
    );
  }
}
