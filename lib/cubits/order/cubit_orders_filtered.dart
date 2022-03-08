import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/services/database.dart';

class CubitOrdersFiltered extends Cubit<OrderState> {
  final Database database;
  final DateTime date;

  late List<Order> orders;

  CubitOrdersFiltered(this.database, {required this.date})
      : super(OrderInitialState()) {
    getOrders();
  }

  void getOrders() async {
    emit(OrderLoadingState());

    try {
      orders = await database.getOrdersByDates(
          start: getDateStart(date), end: getDateEnd(date));
      emit(OrdersLoadedState(orders));
    } catch (e) {
      print(e.toString());
      emit(OrderErrorState(ErrorMessages.errorOnLoadingFromFirestore));
      return;
    }
  }
}
