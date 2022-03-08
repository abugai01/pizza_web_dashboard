import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/routing/routes.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

//TODO: поскольку в onTap в generateCells в любом случае что-то передается, все ячейки становятся tappable, хотя это не гуд
enum SmallTableTypes { Pets, Orders, Executors, Unknown }

// //Необходимо для создания универсальной таблички вместо создания отдельного виджета с таблицей под каждую отдельную сущность
enum OrderModelFields {
  id,
  number,
  username,
  userId,
  driverId,
  status,
  position,
  serviceId,
  petId,
  executorId,
  serviceParameters,
  createdAt,
  updatedAt,
  serviceName
}

// if (widget.data.runtimeType == PetModel) {
//   PetModel _data = widget.data as PetModel;
//   data = _data;
//   pageType = IndividualPageType.Pet;

class SmallTable extends StatefulWidget {
  final dynamic data;
  final Set<String> columnNames;
  final Set<dynamic> fields;
  final Map<dynamic, Function>? functionsMap;

  //TODO: предохраняться от разного количества названий столбцов и значений
  SmallTable(
      {required this.data,
      required this.columnNames,
      required this.fields,
      this.functionsMap});

  @override
  _SmallTableState createState() => _SmallTableState();
}

class _SmallTableState extends State<SmallTable> {
  SmallTableTypes? smallTableType; //TODO: null safety

  @override
  void initState() {
    super.initState();

    if (widget.data is List<Order>) {
      smallTableType = SmallTableTypes.Orders;
    } else {
      smallTableType = SmallTableTypes.Unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.columnNames.length != widget.fields.length) {
      print("Column number not equal to number of fields");
      return Container();
    }
    return Container(
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
            columns: generateColumns(widget.columnNames),
            rows: List<DataRow>.generate(
                widget.data?.length,
                //TODO: надо проверять,что на входе список, а не просто 1 объект (иначе ошибка)
                (index) => DataRow(
                        cells: generateCells(
                      widget.data[index],
                      widget.fields,
                      functionsMap: widget.functionsMap!, //TODO: null safety
                    )))));
  }

  List<DataCell> generateCells(dynamic model, Set<dynamic> fields,
      {required Map<dynamic, Function> functionsMap}) {
    List<DataCell> cells = [];

    if (fields == null || fields.length == 0) return cells;

    fields.forEach((field) {
      cells.add(DataCell(
        CustomText(
          text: model.extractValueFromModel(field),
        ),
        onTap: () {
          //TODO: это сейчас подходит только для навигации по сути, а надо сделать универсально (подумать). Из-за этого сейчас пришлось small_table_of_available_drivers вынести в отдельный виджет
          if (functionsMap != null) {
            if (functionsMap.containsKey(field))
              return functionsMap[field]!(
                  type: smallTableType, data: model); //TODO: null safety
          }
        },
      ));
    });

    return cells;
  }
}

//TODO: учесть DataColumn2 и возможно настройку колонок
List<DataColumn> generateColumns(Set<String> columnNames) {
  List<DataColumn> columns = [];

  if (columnNames == null || columnNames.length == 0) return columns;

  columnNames.forEach((name) {
    columns.add(DataColumn(label: Text(name)));
  });

  return columns;
}

Map<SmallTableTypes, String> routeMap = {
  SmallTableTypes.Pets: petIndividualPageRoute
};
