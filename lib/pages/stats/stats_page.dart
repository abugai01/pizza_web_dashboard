import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/order/cubit_orders_filtered.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/helpers/responsiveness.dart';
import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/models/helpers/data_elem.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/orders_table_small.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/overview_cards.dart';
import 'package:pizza_web_dashboard/routing/controllers.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:pizza_web_dashboard/widgets/order_card.dart';

//TODO: вероятно сюда надо присунуть инфу по платежам
//TODO: возможно в будущем нужна стата за неделю, за месяц и т.п.
class StatsPage extends StatefulWidget {
  //const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final int depth = 30;

  // List<DateTime> dates = [];
  // DateTime selectedDate = DateTime.now();
  late List<DateTime> dates;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    dates = genListOfDates(depth: 30);
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: dates.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: DateToText(dates[index]),
                    selected: dates[index] == selectedDate,
                    onTap: () {
                      setState(() {
                        selectedDate = dates[index];
                      });
                    },
                  );
                }),
          ),
          Expanded(
            flex: 6,
            child: BlocProvider<CubitOrdersFiltered>(
              create: (context) => CubitOrdersFiltered(
                  context.read<FirestoreDatabase>(),
                  date: selectedDate),
              child: BlocBuilder<CubitOrdersFiltered, OrderState>(
                  builder: (context, state) {
                if (state is OrdersLoadedState) {
                  return Row(children: <Widget>[
                    //TODO: поправить incorrect use of parent data widget (связано с expanded и flex)
                    Expanded(
                      flex: 5,
                      child: Column(children: <Widget>[
                        OrdersTableSmall(state.orders),
                      ]),
                    ),
                    Expanded(
                        flex: 1,
                        child: OverviewCards([
                          DataElem("Заказано", 10),
                          DataElem("Выполнено", 7),
                          DataElem("Отменено", 1),
                          DataElem("В процессе", 0),
                        ])), //TODO: сделать!
                  ]);
                } else if (state is OrderLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is OrderErrorState) {
                  return Center(child: Text(state.error));
                }
                return Center(child: Text(ErrorMessages.errorGeneric));
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class DateToText extends StatelessWidget {
  final DateTime date;

  const DateToText(this.date);

  @override
  Widget build(BuildContext context) {
    return Text(rusDateFormatter(date, fmt: DateFormats.DMMM));
  }
}
