import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/models/helpers/table_elem.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/assign_executor_selection_window.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/dropdown_field.dart';
import 'package:pizza_web_dashboard/widgets/table_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/routing/routes.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class SmallTable extends StatelessWidget {
  //final List<TableElem> data;

  //SmallTable(this.data);

  final List<String?>? columns;
  final List<List<String?>?>? values;

  SmallTable({required this.columns, required this.values});

  @override
  Widget build(BuildContext context) {
    return (validate(columns: columns, values: values) == true)
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              // boxShadow: [
              //   BoxShadow(
              //       offset: Offset(0, 6),
              //       color: lightGrey.withOpacity(.1),
              //       blurRadius: 12,
              //   )
              // ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: DataTable(
                columnSpacing: 12,
                horizontalMargin: 12,
                //minWidth: 600,
                columns: genColumns(columns!),
                rows: genRows(values!)),
          )
        : Container();
  }

  List<DataColumn> genColumns(List<String?> columns) {
    List<DataColumn> res = [];

    for (int i = 0; i < columns.length; i++) {
      res.add(DataColumn(label: CustomText(text: columns[i])));
    }

    return res;
  }

  List<DataCell> genCells(List<String?>? list) {
    List<DataCell> res = [];

    for (int i = 0; i < list!.length; i++) {
      res.add(DataCell(CustomText(text: list[i])));
    }

    return res;
  }

  List<DataRow> genRows(List<List<String?>?> values) => List<DataRow>.generate(
      values.length, (index) => DataRow(cells: genCells(values[index])));

  // List<DataColumn> genColumns(List<TableElem> data) {
  //   List<DataColumn> res = [];
  //
  //   for (int i = 0; i < data.length; i++) {
  //     res.add(DataColumn(label: Text(data[i].columnName)));
  //   }
  //
  //   return res;
  // }
  //
  // List<DataCell> genCells(List<TableElem> data) {
  //   List<DataCell> res = [];
  //
  //   for (int i = 0; i < data.length; i++) {
  //     res.add(DataCell(CustomText(text: data[i].value)));
  //   }
  //
  //   return res;
  // }
  //
  // List<DataRow> genRows(List<TableElem> data) => List<DataRow>.generate(
  //     data.length, (index) => DataRow(cells: genCells(data)));

  bool validate(
      {required List<String?>? columns,
      required List<List<String?>?>? values}) {
    print(columns);
    print(values);

    if (columns == null || values == null) return false;
    if (columns.length == 0 || values.length == 0) return false;

    for (int i = 0; i < values.length; i++) {
      if (values[i] == null) return false;
    }

    int columnsCount = columns.length;

    for (int i = 0; i < values.length; i++) {
      if (values[i]!.length != columnsCount) return false;
    }

    return true;
  }
}
