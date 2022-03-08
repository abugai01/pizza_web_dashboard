import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/widgets/custom_list_tile.dart';

// import 'package:pizza_web_dashboard/screens/orders/screens/order_info_screen.dart';
// import 'package:pizza_web_dashboard/config/style.dart';
// import 'package:pizza_web_dashboard/helpers/screen_navigation.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Function? function;

  OrderCard(this.order, {this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (function != null) function!();
        },
        child: Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Верхняя строка с названием услуги и статусом
                  Padding(
                      padding: EdgeInsets.fromLTRB(12, 10, 10, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            //flex: 7,
                            child: Text(
                              //TODO: what should be displayed instead of id?
                              order.id,
                              textAlign: TextAlign.left,
                              style: cardTitleStyle,
                            ),
                          ),
                          Expanded(
                              //flex: 6,
                              child: Container(
                            height: 22,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(order.statusTranslated,
                                  //textAlign: TextAlign.center,
                                  style: cardStatusStyle),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                color: getOrderStatusColor(order.status)),
                          )),
                          SizedBox(width: 5),
                          IconButton(
                              icon: Icon(Icons.link, color: Colors.grey),
                              color: Colors.white,
                              onPressed: () => NavigationController.navigateTo(
                                  context,
                                  route: RouteGenerator.genLink(Routes.order,
                                      id: order.id)))
                        ],
                      )),
                  //Время оказания услуги
                  CustomListTile(order.beginAtString,
                      iconData: Icons.event_outlined),
                  //TODO: здесь что-то должно быть для других услуг
                  //Продолжительность
                  CustomListTile(order.durationInMinutesText,
                      iconData:
                          Icons.timer_outlined), //TODO: что-то вместо этого
                  // Address
                  CustomListTile(order.shortAddressText,
                      iconData: Icons.location_on_outlined),
                  //Вознаграждение исполнителя
                  CustomListTile(order.sum?.executorPriceString,
                      iconData: Icons.paid_outlined),
                  SizedBox(height: 18),
                ])));
  }
}
