import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class OrdersTableSmall extends StatelessWidget {
  final List<Order> data;

  OrdersTableSmall(this.data);

  @override
  Widget build(BuildContext context) {
    return (data.length == 0)
        ? Center(child: CustomText(text: ErrorMessages.messageNoDataOrders))
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                DataColumn2(label: Text("Подробно"), size: ColumnSize.S),
                DataColumn2(label: Text("№"), size: ColumnSize.S),
                DataColumn(label: Text('Статус')),
                DataColumn(label: Text('Дата/время выполнения')),
                DataColumn(label: Text('Стоимость')),
                DataColumn(label: Text('Исполнитель')),
              ],
              rows: List<DataRow>.generate(
                data.length,
                (index) => DataRow(
                  cells: [
                    DataCell(IconButton(
                      icon: Icon(Icons.link),
                      color: orderLinkColor,
                      onPressed: () {
                        NavigationController.navigateTo(context,
                            route: RouteGenerator.genLink(Routes.order,
                                orderId: data[index].id));
                      },
                    )),
                    DataCell(CustomText(text: data[index].number.toString())),
                    DataCell(CustomText(text: data[index].statusText)),
                    DataCell(CustomText(text: data[index].beginAtString)),
                    DataCell(
                        CustomText(text: data[index].sum?.customerPriceString)),
                    //TODO: возможно имя исполнителя сюда еще вытащить
                    DataCell(
                      data[index].executorId == null
                          ? CustomText(text: 'Не назначен')
                          : IconButton(
                              icon: Icon(Icons.link),
                              color: executorLinkColor,
                              onPressed: () {
                                NavigationController.navigateTo(context,
                                    route: RouteGenerator.genLink(
                                        Routes.executor,
                                        executorId: data[index].executorId));
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
