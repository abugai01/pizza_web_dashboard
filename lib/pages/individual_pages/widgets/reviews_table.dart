import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/models/review.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:pizza_web_dashboard/widgets/rating_star.dart';

class ReviewsTable extends StatelessWidget {
  final List<Review> data;

  ReviewsTable(this.data);

  @override
  Widget build(BuildContext context) {
    return (data.length == 0)
        ? Center(child: CustomText(text: ErrorMessages.messageNoDataReviews))
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                DataColumn2(label: Text('Оценка'), size: ColumnSize.S),
                DataColumn2(label: Text('Текст'), size: ColumnSize.L),
                DataColumn(label: Text('Заказ')), //TODO: кликабельная ссылка
                DataColumn(
                    label: Text("Пользователь")), //TODO: кликабельная ссылка
                DataColumn(label: Text('Дата')),
              ],
              rows: List<DataRow>.generate(
                data.length,
                (index) => DataRow(
                  cells: [
                    // DataCell(
                    //   CustomText(text: data[index].name),
                    //   onTap: () {
                    //     NavigationController.navigateToWithRouteList(context,
                    //         routeList: [
                    //           userIndividualPageRoute,
                    //           userId,
                    //           petsPageRoute,
                    //           data[index].id!
                    //         ]);
                    //   },
                    // ),
                    DataCell(RatingStar(data[index].valueString)),
                    DataCell(CustomText(
                        text: data[index]
                            .text)), //TODO: высотку строки адаптировать!
                    DataCell(CustomText(text: data[index].orderId)),
                    DataCell(CustomText(text: data[index].userId)),
                    DataCell(
                      CustomText(text: data[index].createdAtFormatted),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
