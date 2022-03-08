import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/cubits/order/cubit_orders.dart';
import 'package:uuid/uuid.dart';

//TODO: оптимизировать код! или хер уже с ним, подумать
//TODO: возможность загрузки?
class OrderFilterButtons extends StatelessWidget {
  final FilterTypeStatus filterStatus;

  const OrderFilterButtons({required this.filterStatus});

  @override
  Widget build(BuildContext context) {
    double fontSize = 10;
    double rowHeight = 20;
    double spaceBetween = 5;
    Color activeColor1 = Colors.pink;
    Color activeColor2 = Colors.orangeAccent;
    Color inactiveColor = Colors.grey[350]!;

    return Container(
        height: rowHeight,
        child: Row(
          children: [
            SizedBox(width: spaceBetween),
            FloatingActionButton.extended(
              heroTag: Uuid().v1(),
              onPressed: () => context
                  .read<CubitOrders>()
                  .updateFilterSelection(filterStatus: FilterTypeStatus.All),
              label: Text('All',
                  style: TextStyle(
                      fontSize: fontSize)), //todo: status not hardcode!
              backgroundColor: filterStatus == FilterTypeStatus.All
                  ? activeColor2
                  : inactiveColor,
            ),
            SizedBox(width: spaceBetween * 2),
            VerticalDivider(),
            SizedBox(width: spaceBetween * 2),
            FloatingActionButton.extended(
              heroTag: Uuid().v1(),
              onPressed: () => context
                  .read<CubitOrders>()
                  .updateFilterSelection(filterStatus: FilterTypeStatus.Active),
              label: Text('Active', style: TextStyle(fontSize: fontSize)),
              backgroundColor: filterStatus == FilterTypeStatus.Active
                  ? activeColor2
                  : inactiveColor,
            ),
            SizedBox(width: spaceBetween),
            FloatingActionButton.extended(
              heroTag: Uuid().v1(),
              onPressed: () => context
                  .read<CubitOrders>()
                  .updateFilterSelection(
                      filterStatus: FilterTypeStatus.Finished),
              label: Text('Finished', style: TextStyle(fontSize: fontSize)),
              backgroundColor: filterStatus == FilterTypeStatus.Finished
                  ? activeColor2
                  : inactiveColor,
            ),
            SizedBox(width: spaceBetween),
            FloatingActionButton.extended(
              heroTag: Uuid().v1(),
              onPressed: () => context
                  .read<CubitOrders>()
                  .updateFilterSelection(
                      filterStatus: FilterTypeStatus.Waiting),
              label: Text('Ожидание', style: TextStyle(fontSize: fontSize)),
              backgroundColor: filterStatus == FilterTypeStatus.Waiting
                  ? activeColor2
                  : inactiveColor,
            ),
            SizedBox(width: spaceBetween),
            FloatingActionButton.extended(
              heroTag: Uuid().v1(),
              onPressed: () => context
                  .read<CubitOrders>()
                  .updateFilterSelection(
                      filterStatus: FilterTypeStatus.Cancelled),
              label: Text('Отмена', style: TextStyle(fontSize: fontSize)),
              backgroundColor: filterStatus == FilterTypeStatus.Cancelled
                  ? activeColor2
                  : inactiveColor,
            ),
            SizedBox(width: spaceBetween),
          ],
        ));
  }
}
