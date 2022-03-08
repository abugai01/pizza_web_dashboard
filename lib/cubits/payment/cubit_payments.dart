import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/models/basic/payment.dart';
import 'package:pizza_web_dashboard/services/database.dart';

class CubitPayments extends Cubit<PaymentState> {
  final Database database;

  late List<Payment> payments;

  CubitPayments(this.database) : super(PaymentInitialState()) {
    getPayments();
  }

  void getPayments() async {
    emit(PaymentLoadingState());

    try {
      payments = await database.getPayments();
      emit(PaymentsLoadedState(payments));
    } catch (e) {
      print(e.toString());
      emit(PaymentErrorState(ErrorMessages.errorOnLoadingFromFirestore));
      return;
    }
  }
}
