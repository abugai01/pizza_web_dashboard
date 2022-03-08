import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/order/cubit_order.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/widgets/main_info_header.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/widgets/order_details.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/services/database.dart';

//TODO: время в текущем статусе показывать (now - updatedAt)
class OrderIndividualPage extends StatelessWidget {
  final String orderId;

  OrderIndividualPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      child: BlocProvider<CubitOrder>(
        create: (context) =>
            CubitOrder(context.read<FirestoreDatabase>(), orderId: orderId),
        child: BlocBuilder<CubitOrder, OrderState>(builder: (context, state) {
          if (state is OrderLoadedState) {
            return OrderPageContent(state.order);
          } else if (state is OrderLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderErrorState) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text(ErrorMessages.errorGeneric));
        }),
      ),
    );
  }
}

//TODO: ссылка на пользака и исполнителя и животное!
class OrderPageContent extends StatelessWidget {
  final Order order;

  const OrderPageContent(this.order);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          //TODO: не показывать кружок с авой вообще!
          MainInfoHeader(
            id: order.id,
            mainInfo: order.id, //TODO: не забыть продолжительность + not id!!
            additionalInfo: [
              order.beginAtString,
              order.addressText,
              order.statusText,
            ],
            //TODO: сделать уже нормально этот хедер и кнопки
            //TODO: только для активных заказов!
            routes: [Routes.orderMap],
          ),
          SizedBox(height: 25),
          OrderDetails(order),
        ],
      ),
    );
  }
}
