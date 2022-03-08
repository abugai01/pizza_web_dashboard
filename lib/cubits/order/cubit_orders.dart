import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/services/database.dart';

enum FilterTypeStatus { All, Active, Finished, Cancelled, Waiting }

class CubitOrders extends Cubit<OrderState> {
  final Database database;

  late List<Order> orders;

  CubitOrders(this.database) : super(OrderInitialState()) {
    //TODO: это все-таки должно браться изначально из CubitWeekSelector
    loadOrders(getWeekRange(DateTime.now()));
  }

  FilterTypeStatus _filterStatus = FilterTypeStatus.All;

  FilterTypeStatus get filterStatus => _filterStatus;

  void loadOrders(DateTimeRange range) async {
    emit(OrderLoadingState());

    try {
      orders =
          await database.getOrdersByDates(start: range.start, end: range.end);

      filterOrders(orders);

      //emit(OrdersLoadedState(orders));
    } catch (e) {
      print(e.toString());
      emit(OrderErrorState(ErrorMessages.errorOnLoadingFromFirestore));
      return;
    }
  }

  void updateFilterSelection({FilterTypeStatus? filterStatus}) {
    bool shouldUpdate = false;

    if (filterStatus != null && filterStatus != _filterStatus) {
      _filterStatus = filterStatus;
      shouldUpdate = true;
    }

    if (shouldUpdate == true) filterOrders(orders);
  }

  //TODO: возможно это должно быть не в кубите а в logic компоненте
  void filterOrders(List<Order> src) {
    List<Order> res = src;

    res = _filterByStatus(res, filter: _filterStatus);

    emit(OrdersLoadedState(res));
  }

  List<Order> _filterByStatus(List<Order> src,
      {required FilterTypeStatus filter}) {
    if (filter == FilterTypeStatus.All) {
      return src;
    } else {
      List<Order> res = [];

      if (filter == FilterTypeStatus.Active) {
        res = src.where((order) => order.isActive == true).toList();
      } else if (filter == FilterTypeStatus.Finished) {
        res = src.where((order) => order.isFinished == true).toList();
      } else if (filter == FilterTypeStatus.Cancelled) {
        res = src.where((order) => order.isCancelled == true).toList();
      } else if (filter == FilterTypeStatus.Waiting) {
        res = src.where((order) => order.isWaiting == true).toList();
      }

      return res;
    }
  }
}
