import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/cubits/user/cubit_users.dart';
import 'package:pizza_web_dashboard/helpers/responsiveness.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/pages/users/widgets/users_table.dart';
import 'package:pizza_web_dashboard/routing/controllers.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  BlocProvider<CubitUsers>(
                    create: (context) =>
                        CubitUsers(context.read<FirestoreDatabase>()),
                    child: BlocBuilder<CubitUsers, UserState>(
                        builder: (context, state) {
                      if (state is UsersLoadedState) {
                        return UsersTable(state.users);
                      } else if (state is UserLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is UserErrorState) {
                        return Center(
                            child: Text(ErrorMessages
                                .errorOnLoadingFromFirestore)); //TODO: кубит
                      }
                      return Center(child: Text(ErrorMessages.errorGeneric));
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
