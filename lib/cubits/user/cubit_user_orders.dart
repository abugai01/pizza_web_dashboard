import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/services/database.dart';

class CubitUserOrders extends Cubit<OrderState> {
  final Database database;
  final String userId;

  late List<Order> orders;

  CubitUserOrders(this.database, {required this.userId})
      : super(OrderInitialState()) {
    getUserOrders();
  }

  void getUserOrders() async {
    emit(OrderLoadingState());

    try {
      orders = await database.getUserOrders(userId: userId);
      emit(OrdersLoadedState(orders));
    } catch (e) {
      print(e.toString());
      emit(OrderErrorState(ErrorMessages.errorOnLoadingFromFirestore));
      return;
    }
  }
}
