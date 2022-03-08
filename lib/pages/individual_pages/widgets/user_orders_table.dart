import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/models/user.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/widgets/small_table.dart';
//TODO: убрать лишние импорты

//TODO: надо ли тут stateful? подумать
//TODO: эту обретку тоже можно сделать универсальной и не привязываться конкретно к этой таблице
//TODO: также возможно нужна ожна общая обертка, чтобы не было много лоадеров одновременно на странице

// navigate({SmallTableTypes? type, dynamic data}) {
//   //TODO: null safety
//   if (routeMap.containsKey(type) && data != null)
//     navigationController.navigateTo(routeMap[type]!,
//         arguments: data); //TODO: null safety
// }

//Табличка с заказами на странице пользователя
class UserOrdersTable extends StatefulWidget {
  final User data;

  UserOrdersTable(this.data);

  @override
  _UserOrdersTableState createState() => _UserOrdersTableState();
}

class _UserOrdersTableState extends State<UserOrdersTable> {
  //OrderServices _orderService = OrderServices();
  late Future<List<Order>> futureData;

  @override
  void initState() {
    super.initState();
    //futureData = _orderService.getOrdersByUserId(widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          //TODO: пустую табличку наверное не надо возвращать или хотя бы писать что данных нет
          return SmallTable(data: snapshot.data, columnNames: {
            "Номер заказа",
            "Дата создания",
            "Услуга",
            "Статус"
          }, fields: {
            OrderModelFields.number,
            OrderModelFields.createdAt,
            OrderModelFields.serviceName,
            OrderModelFields.status,
          });
        } else if (snapshot.hasError) {
          if (snapshot.data == null) {
            return Center(
                child: Text(
              'Нет данных',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ));
          }
          return Center(child: Text('${snapshot.error}'));
        }
        return CircularProgressIndicator();
      },
    );
  }
}

//Для передачи в виджет SmallTable функции должны принимать аргументы только в таком виде
//TODO: один и тот же id сейчас в executorId и orderId !!!!!!!!!!!!!!!!!!!!!!!!!!!
// assignExecutor({SmallTableTypes? type, required dynamic data}) {
//   OrderServices().assignExecutor(
//       executorId: data.id,
//       orderId: data.id,
//       currentStatus: getEnumByStatus(data.status));
// }
