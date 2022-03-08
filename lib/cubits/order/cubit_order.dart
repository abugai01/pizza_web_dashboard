import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/services/database.dart';

class CubitOrder extends Cubit<OrderState> {
  final Database database;
  final String orderId;

  CubitOrder(this.database, {required this.orderId})
      : super(OrderInitialState()) {
    loadOrder();
  }

  late Order _order;

  void loadOrder() async {
    emit(OrderLoadingState());

    try {
      _order = await database.getOrder(orderId: orderId);
      _order.isNull == true
          ? emit(OrderErrorState(ErrorMessages.messageNoDocumentId))
          : emit(OrderLoadedState(_order));
    } catch (e) {
      print(e.toString());
      emit(OrderErrorState(ErrorMessages.errorOnLoadingFromFirestore));
      return;
    }

    emit(OrderLoadedState(_order));
  }
}
