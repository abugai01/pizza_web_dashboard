import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';
import 'package:pizza_web_dashboard/logic/order_helper.dart';
import 'package:pizza_web_dashboard/models/constants/order_constants.dart';
import 'package:pizza_web_dashboard/models/helpers/data_elem.dart';
import 'package:pizza_web_dashboard/models/order.dart';

class StatsCalculator {
  //TODO: можно взять готовую функцию genListOfDates
  static List<DataElem> groupOrdersByDate(List<Order> orders, {int depth = 7}) {
    List<DataElem> res = [];

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    for (int i = 0; i < depth; i++) {
      DateTime date = today.subtract(Duration(days: i));
      String dateFormatted = rusDateFormatter(date, fmt: DateFormats.DMMM);
      int count = _countOrdersByDate(orders: orders, date: date);
      DataElem elem = DataElem(dateFormatted, count);
      res.add(elem);
    }

    return res;
  }

  static int _countOrdersByDate(
      {required List<Order> orders, required DateTime date}) {
    int res = 0;

    for (int i = 0; i < orders.length; i++) {
      DateTime? orderDateTime = orders[i].beginAt;

      if (orderDateTime != null) {
        DateTime roundedDate = DateTime(
            orderDateTime.year, orderDateTime.month, orderDateTime.day);
        if (roundedDate == date) res++;
      }
    }

    return res;
  }

  static List<DataElem> groupOrdersByStatus(List<Order> orders) {
    List<DataElem> res = [];

    for (int i = 0; i < OrderConstants.options_status.length; i++) {
      OrderStatus status = OrderConstants.options_status[i];
      String statusText = OrderHelper.statusToString(status).toString();
      int count = _countOrdersByStatus(orders: orders, status: status);
      DataElem elem = DataElem(statusText, count);
      res.add(elem);
    }

    return res;
  }

  static int _countOrdersByStatus(
      {required List<Order> orders, required OrderStatus status}) {
    int res = 0;

    for (int i = 0; i < orders.length; i++) {
      if (orders[i].status == status) res++;
    }

    return res;
  }
}
