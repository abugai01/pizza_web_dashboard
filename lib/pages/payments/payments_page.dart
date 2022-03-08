import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/payment/cubit_payments.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/helpers/responsiveness.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/pages/payments/widgets/payment_table.dart';
import 'package:pizza_web_dashboard/routing/controllers.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class PaymentsPage extends StatelessWidget {
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
                  BlocProvider<CubitPayments>(
                    create: (context) =>
                        CubitPayments(context.read<FirestoreDatabase>()),
                    child: BlocBuilder<CubitPayments, PaymentState>(
                        builder: (context, state) {
                      if (state is PaymentsLoadedState) {
                        return PaymentsTable(state.payments);
                      } else if (state is PaymentLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PaymentErrorState) {
                        return Center(child: Text(state.error));
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
