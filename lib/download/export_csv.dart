import 'dart:html';

import 'package:csv/csv.dart';
import 'package:pizza_web_dashboard/download/csv_converter.dart';

class ExportCsv {
  static void convertAndDownload(List<dynamic> data) =>
      _downloadData(CsvConverter.convertData(data));

  static void _downloadData(List<List<dynamic>>? data) {
    if (data == null) return;

    String csv = const ListToCsvConverter().convert(data);

    new AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
      ..setAttribute("download", "data.csv")
      ..click();
  }
}
