//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/widgets/custom_data_row.dart';
import 'package:pizza_web_dashboard/widgets/custom_divider.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class OrderDetails extends StatelessWidget {
  final Order order;

  OrderDetails(this.order);

  @override
  Widget build(BuildContext context) {
    //TODO: не забыть комментарий!

    List<Widget> list1 = [
      //TODO: реализовать кликабельные ссылки!
      CustomText(
          text: "Основная информация", size: 16, weight: FontWeight.bold),
      SizedBox(height: 25),
      CustomDataRow("Номер заказа", order.number.toString()), //TODO: в модель
      CustomDataRow("Подробная информация об услуге",
          "не забыть"), //TODO: сделать, тут наверное про продолжительность надо
      CustomDataRow("Клиент", order.userId),
      CustomDataRow("Исполнитель", order.executorId),
      CustomDataRow("Адрес", order.addressText),
    ];

    List<Widget> list2 = [
      CustomDivider(),
      CustomText(text: "Стоимость", size: 16, weight: FontWeight.bold),
      SizedBox(height: 25),
      CustomDataRow("Цена для клиента", order.sum?.customerPriceString),
      CustomDataRow("Цена для исполнителя", order.sum?.executorPriceString),
      CustomDataRow("Прибыль от заказа", order.sum?.profitString),
      CustomDataRow("Статус платежа",
          "Успешно"), //TODO: реализовать! или подумать надо ли
    ];

    //TODO: красивенько сделать статус
    List<Widget> list3 = [
      CustomDivider(),
      CustomText(text: "Статус", size: 16, weight: FontWeight.bold),
      SizedBox(height: 25),
      CustomDataRow("Текущий статус", order.statusText),
      CustomDataRow("Дата создания заказа", order.createdAtFormatted),
      CustomDataRow("Время последнего обновления", order.updatedAtFormatted),
    ];

    List<Widget> list4 = [
      CustomDivider(),
      CustomText(text: "Детали заказа", size: 16, weight: FontWeight.bold),
      SizedBox(height: 25),
      CustomDataRow("Время выполнения", order.beginAtString),
      CustomDataRow("Комментарий", order.comment),
    ];

    List<Widget> list5 = [
      CustomDivider(),
      CustomText(text: "Оценка и отзыв", size: 16, weight: FontWeight.bold),
      SizedBox(height: 25),
      CustomDataRow("Оценка", "2.9"), //TODO: сделать
      CustomDataRow("Отзыв", "Полный ацтой"), //TODO: сделать
    ];

    List<Widget> children =
        [list1, list2, list3, list4, list5].expand((x) => x).toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}
