import 'package:pizza_web_dashboard/models/internal/executor_stat.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/models/user.dart';

class CsvConverter {
  static List<List<dynamic>>? convertData(List<dynamic> data) {
    if (data.length == 0) return null;

    switch (data.first.runtimeType) {
      case Order:
        return _convertOrders(data as List<Order>);
      case User:
        return _convertUsers(data as List<User>);
      case ExecutorStat:
        return _convertExecutorStats(data as List<ExecutorStat>);
    }
    return null;
  }

  static List<List<dynamic>> _convertOrders(List<Order> data) {
    List<List<dynamic>> rows = [];

    for (int i = 0; i < data.length; i++) {
      List<dynamic> row = [];

      row.add(data[i].id);
      row.add(data[i].number);
      row.add(data[i].userId);
      row.add(data[i].sum?.customer);
      row.add(data[i].sum?.executor);
      row.add(data[i].sum?.currency?.international);
      row.add(data[i].beginAt);
      row.add(data[i].endAt);
      row.add(data[i].createdAt);
      row.add(data[i].statusText);
      row.add(data[i].executorId);
      row.add(data[i].address?.city);
      row.add(data[i].address?.description);
      row.add(data[i].address?.lat);
      row.add(data[i].address?.lng);
      row.add(data[i].subscriptionId);
      //TODO: оценка!

      rows.add(row);
    }

    List<String> headers = [
      "id",
      "number",
      "userId",
      "serviceType",
      "serviceName",
      "sumCustomer",
      "sumExecutor",
      "sumCurrency",
      "beginAt",
      "endAt",
      "createdAt",
      "statusText",
      "executorId",
      "executorName",
      "executorEmail",
      "executorPhone",
      "petId",
      "petType",
      "petBreed",
      "petName",
      "addressCity",
      "addressDescription",
      "addressLat",
      "addressLng",
      "subscriptionId",
    ];

    rows = addHeaders(rows, headers);

    return rows;
  }

  static List<List<dynamic>> _convertUsers(List<User> data) {
    List<List<dynamic>> rows = [];

    for (int i = 0; i < data.length; i++) {
      List<dynamic> row = [];

      row.add(data[i].id);
      row.add(data[i].name);
      row.add(data[i].surname);
      row.add(data[i].phone);
      row.add(data[i].email);

      rows.add(row);
    }

    List<String> headers = [
      "id",
      "name",
      "surname",
      "phone",
      "email",
    ];

    rows = addHeaders(rows, headers);

    return rows;
  }

  static List<List<dynamic>> _convertExecutorStats(List<ExecutorStat> data) {
    List<List<dynamic>> rows = [];

    for (int i = 0; i < data.length; i++) {
      List<dynamic> row = [];

      row.add(data[i].id);
      row.add(data[i].name);
      row.add(data[i].serviceCount);
      row.add(data[i].receivables);
      row.add(data[i].orderNumbers);
      row.add(data[i].range?.start);
      row.add(data[i].range?.end);

      rows.add(row);
    }

    List<String> headers = [
      "id",
      "name",
      "serviceCount",
      "receivables",
      "orderNumbers",
      "dateTimeRangeStart",
      "dateTimeRangeEnd",
    ];

    rows = addHeaders(rows, headers);

    return rows;
  }

  static List<List<dynamic>> addHeaders(
      List<List<dynamic>> data, List<String> headers) {
    List<List<dynamic>> res = data;
    res.insert(0, headers);
    return res;
  }
}
