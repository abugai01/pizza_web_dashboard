import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/models/basic/profile.dart';
import 'package:pizza_web_dashboard/models/basic/rating.dart';
import 'package:pizza_web_dashboard/models/order.dart';

class ExecutorStat {
  static const ID = 'id';
  static const NAME = 'name';
  static const SERVICE_COUNT = 'serviceCount';
  static const RECEIVABLES = 'name';
  static const RANGE = 'range';
  static const ORDERS = 'orders';

  String id;
  String? name;
  num serviceCount;
  num receivables;
  DateTimeRange? range;
  List<Order> orders;

  //TODO: номера заказов? надо чтобы во всплывающем окошке появлялось наверное

  ExecutorStat({
    required this.id,
    this.name,
    this.serviceCount = 0,
    this.receivables = 0,
    this.range,
    List<Order>? orders,
  }) : this.orders = orders ?? [];

  String get receivablesText =>
      receivables.toStringAsFixed(0) +
      ' ' +
      '₽'; //TODO: заложиться в будущем на другие валюты (т.е. чтобы рубль не был захардкожен)
  String get orderNumbers => convertListToString(
      orders.map((order) => order.number.toString()).toList());
  //TODO: добавить геттер, рассчитывающий среднюю оценку, если это будет в заказе
}
