import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/logic/stats_calculator.dart';
import 'package:pizza_web_dashboard/models/helpers/data_elem.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/widgets/custom_data_row.dart';
import 'package:pizza_web_dashboard/widgets/custom_divider.dart';

class OrdersStats extends StatelessWidget {
  final List<Order> orders;

  const OrdersStats({required this.orders});

  @override
  Widget build(BuildContext context) {
    List<DataElem> ordersByStatus = StatsCalculator.groupOrdersByStatus(orders);
    List<DataElem> ordersByDate = StatsCalculator.groupOrdersByDate(orders);

    return Container(
      padding: EdgeInsets.all(8),
      child: Column(children: <Widget>[
        //TODO: мб неактивные статусы не показывать?
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: ordersByStatus.length,
              itemBuilder: (context, index) {
                return Container(
                    child: CustomDataRow1(
                  field: ordersByStatus[index].key,
                  value: ordersByStatus[index].value,
                  leftColumnFlex: 3,
                ));
              },
            ),
          ),
        ),
        CustomDivider(),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: ordersByDate.length,
              itemBuilder: (context, index) {
                return Container(
                    child: CustomDataRow1(
                  field: ordersByDate[index].key,
                  value: ordersByDate[index].value,
                  leftColumnFlex: 3,
                ));
              },
            ),
          ),
        ),
      ]),
    );
  }
}
