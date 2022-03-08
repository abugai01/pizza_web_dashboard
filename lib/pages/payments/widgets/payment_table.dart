import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/models/basic/payment.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class PaymentsTable extends StatelessWidget {
  final List<Payment> data;

  PaymentsTable(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          DataColumn(
            label: Text("Создан"),
          ),
          DataColumn2(
            label: Text("Сумма"),
            size: ColumnSize.S,
          ),
          //TODO: цвета для статусов чтобы наглядно было!
          DataColumn(
            label: Text('Статус'),
          ),
          DataColumn(
            label: Text('Идентификатор'),
          ),
          DataColumn(
            label: Text('Изменен'),
          ),
          DataColumn2(
            label: Text('Клиент'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Заказ'),
            size: ColumnSize.S,
          ),
        ],
        rows: List<DataRow>.generate(
          data.length,
          (index) => DataRow(
            cells: [
              DataCell(CustomText(text: data[index].createdAtFormatted)),
              DataCell(CustomText(text: data[index].sumFormatted)),
              DataCell(CustomText(text: data[index].status)),
              DataCell(CustomText(text: data[index].paymentId)),
              DataCell(CustomText(text: data[index].updatedAtFormatted)),
              DataCell(IconButton(
                icon: Icon(Icons.link),
                color: userLinkColor,
                onPressed: () {
                  NavigationController.navigateTo(context,
                      route: RouteGenerator.genLink(Routes.user,
                          userId: data[index].userId));
                },
              )),
              DataCell(IconButton(
                icon: Icon(Icons.link),
                color: orderLinkColor,
                onPressed: () {
                  NavigationController.navigateTo(context,
                      route: RouteGenerator.genLink(Routes.order,
                          orderId: data[index].orderId));
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
