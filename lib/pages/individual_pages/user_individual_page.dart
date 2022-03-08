import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/cubits/user/cubit_user.dart';
import 'package:pizza_web_dashboard/cubits/user/cubit_user_orders.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/models/user.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/widgets/main_info_header.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/orders_table_small.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/services/database.dart';

//TODO: вставить не дефолтную картинку

class UserIndividualPage extends StatelessWidget {
  final String userId;

  UserIndividualPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      child: BlocProvider<CubitUser>(
        create: (context) =>
            CubitUser(context.read<FirestoreDatabase>(), userId: userId),
        child: BlocBuilder<CubitUser, UserState>(builder: (context, state) {
          if (state is UserLoadedState) {
            return UserPageContent(state.user);
          } else if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserErrorState) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text(ErrorMessages.errorGeneric));
        }),
      ),
    );
  }
}

class UserPageContent extends StatelessWidget {
  final User user;

  const UserPageContent(this.user);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          MainInfoHeader(
            id: user.id,
            mainInfo: user.fullName,
            additionalInfo: [user.email, user.phone],
            //TODO: добавить отдельную страницу с адресами (подумать)
            routes: [Routes.userPets],
          ),
          SizedBox(height: 25),
          BlocProvider<CubitUserOrders>(
            create: (context) => CubitUserOrders(
                context.read<FirestoreDatabase>(),
                userId: user.id),
            child: BlocBuilder<CubitUserOrders, OrderState>(
                builder: (context, state) {
              if (state is OrdersLoadedState) {
                return OrdersTableSmall(state.orders);
              } else if (state is OrderLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrderErrorState) {
                return Center(child: Text(state.error));
              }
              return Center(child: Text(ErrorMessages.errorGeneric));
            }),
          ),
        ],
      ),
    );
  }
}
