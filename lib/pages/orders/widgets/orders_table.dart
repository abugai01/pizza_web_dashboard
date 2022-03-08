import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/logic/order_helper.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/dropdown_field.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:pizza_web_dashboard/widgets/table_button.dart';

//TODO: текст поменьше сделать!
//TODO: подгружать постепенно, т.к. иначе очень долго будет. Скорость загрузки небольшая :(
//TODO: подтверждение отмены заказы
//TODO: запись действия, кто отменил и что-либо еще нехорошее сделал
//TODO: обновлять таблицу после нажатия кнопки изменения статуса или отмены. Очень нужен визуальный фидбек!!! также возможно стоит обновлять не все, а один конкретный заказ, который обновился
//TODO: не всегда получается кликнуть с 1 раза по полю с дропдауном
//TODO: не давать выбирать абсолютно любой статус, подумать что разрешать а что нет
class OrdersTable extends StatelessWidget {
  final List<Order> orders;

  //TODO: докинуть сюда питомца
  OrdersTable(this.orders);

  @override
  Widget build(BuildContext context) {
    final double textSize = 12;

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
              DataColumn2(label: Text("Description"), size: ColumnSize.S),
              DataColumn2(
                  label: Text("Город"), size: ColumnSize.M), //todo: address
              DataColumn2(label: Text("№"), size: ColumnSize.S),
              DataColumn2(label: Text("Клиент"), size: ColumnSize.S),
              DataColumn(label: Text('Статус')),
              //TODO:предусмотреть роль, чтобы не всем было доступно
              DataColumn(label: Text('Изменить статус')),
              DataColumn(label: Text('Время начала')),
              //TODO: блокировать поле в зав-ти от статуса. Не всегда можно назначать!
              DataColumn(label: Text('Отменить')),
              DataColumn(label: Text('Исполнитель') //TODO: добавить имя хотя бы
                  ),
            ],
            rows: List<DataRow>.generate(
                orders.length,
                (index) => DataRow(cells: [
                      DataCell(IconButton(
                          icon: Icon(Icons.link),
                          color: orderLinkColor,
                          onPressed: () {
                            NavigationController.navigateTo(context,
                                route: RouteGenerator.genLink(Routes.order,
                                    id: orders[index].id));
                          })),
                      DataCell(CustomText(
                          text: orders[index].address?.city, size: textSize)),
                      DataCell(
                          CustomText(text: orders[index].number.toString())),
                      DataCell(IconButton(
                          icon: Icon(Icons.link),
                          color: userLinkColor,
                          onPressed: () {
                            NavigationController.navigateTo(context,
                                route: RouteGenerator.genLink(Routes.user,
                                    id: orders[index].userId));
                          })),
                      //TODO: userName сделать наверное
                      DataCell(CustomText(text: orders[index].statusText)),
                      //TODO: обновлять при обновлении статуса через поле, или обновлять все данные вообще. Подумать
                      //TODO: защититься на случай разных данных (сейчас валится в ошибку, если нет initialValue в dropdownList)
                      DataCell(
                        DropdownField(
                          OrderHelper.getStatusesList(isTranslated: true),
                          initialValue: orders[index].statusTranslated,
                          function: (_status) {
                            // _orderService.updateStatus(data[index].id,
                            //     newStatus: getEnumByStatus(_status,
                            //         isTranslated: true));
                            //TODO: обновление заказа вернуть!
                          },
                        ),
                      ),
                      DataCell(CustomText(text: orders[index].beginAtString)),
                      //TODO: логику что можно, а что нельзя отменить, лучше убрать в модель или сервис
                      DataCell(TableButton("Отменить", function: () {
                        //_orderService.cancelOrder(data[index].id);
                        //TODO: отмену реализовать и подумать вообще про это
                      },
                          design: TableButtonDesign.red,
                          isEnabled:
                              orders[index].canBeCancelled ? false : true)),
                      // DataCell(
                      //   TextFormField(
                      //     controller: TextEditingController(text: "SomeText"),
                      //     //initialValue: "Initial value",
                      //     keyboardType: TextInputType.text,
                      //     onFieldSubmitted: (val) {
                      //       print('onSubmited $val');
                      //     },
                      //   ),
                      // )
                      DataCell(orders[index].executorId == null
                          ? Text("Не назначен")
                          : IconButton(
                              icon: Icon(Icons.link),
                              color: executorLinkColor,
                              onPressed: () {
                                NavigationController.navigateTo(context,
                                    route: RouteGenerator.genLink(
                                        Routes.executor,
                                        id: orders[index].executorId));
                              })),
                    ]))));
  }
}

// Checkbox(value: checkBoxValue,
//           activeColor: Colors.green,
//           onChanged:(bool newValue){
//         setState(() {
//           checkBoxValue = newValue;
//         });
