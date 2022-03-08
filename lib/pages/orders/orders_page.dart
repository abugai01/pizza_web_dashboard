import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/order/cubit_orders.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/cubits/ui/cubit_week_selector.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/order_filter_buttons.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/orders_stats.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/orders_table.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:pizza_web_dashboard/widgets/week_selector.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      //TODO: убедиться что стейт не сохраняется если на другой странице потыкаться!!!
      child: MultiBlocProvider(
        providers: [
          // CubitWeekSelector должен обязательно быть над табличкой и непосредственно селектором
          BlocProvider<CubitWeekSelector>(
            create: (context) => CubitWeekSelector(),
            lazy: false,
          ),
          // CubitOrders выносим над содержимым таблицы, чтобы работали кнопки фильтрации
          BlocProvider<CubitOrders>(
            create: (context) => CubitOrders(context.read<FirestoreDatabase>()),
            //lazy: false,
          )
        ],
        child: BlocListener<CubitWeekSelector, WeekSelectorGenericState>(
          listener: (context, state) {
            print(state);
            if (state is WeekSelectorGenericState) {
              context.read<CubitOrders>().loadOrders(state.weekRange);
            }
          },
          child: BlocBuilder<CubitOrders, OrderState>(
            builder: (context, state) {
              print(state);

              if (state is OrdersLoadedState) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: CustomText(
                              text: "Заказы",
                              //TODO: это можно сихнронизировать с адресом/контроллером меню
                              size: 20,
                              weight: FontWeight.bold,
                            )),
                        OrderFilterButtons(filterStatus: state.filterStatus),
                        Expanded(child: Container()),
                        WeekSelector(),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListView(children: [
                                OrdersTable(state.orders),
                              ]),
                            ),
                            //TODO: это лучше на отдельную страницу!!
                            Expanded(
                                flex: 1,
                                child: OrdersStats(orders: state.orders)),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is OrderLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrderErrorState) {
                return Center(
                    child: Text(ErrorMessages.errorOnLoadingFromFirestore));
              }
              return Center(child: Text(ErrorMessages.errorGeneric));
            },
          ),
        ),
      ),
    );
  }
}
