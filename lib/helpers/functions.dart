import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';

dynamic extractFromSnapshot(DocumentSnapshot<Object?> snapshot, Object field,
    {Type? type}) {
  dynamic data;

  try {
    data = snapshot.get(field);
  } on StateError catch (_) {
    print("Field " +
        field.toString().toUpperCase() +
        " is not found in the snapshot with id ${snapshot.id}");
  } catch (e) {
    print(e.toString());
  }

  if (data == null && type != null) {
    switch (type) {
      case String:
        data = '';
        break;
      case int:
        data = 0;
        break;
      case bool:
        data = false;
        break;
      case double:
        data = 0.0;
        break;
      case Map:
        data = {};
        break;
      case List:
        data = [];
        break;
    }
  }

  return data;
}

bool isCyrillic(String value) {
  return RegExp(
          r'^[аАбБвВгГдДеЕёЁжЖзЗиИйЙкКлЛмМнНоОпПрРсСтТуУфФхХцЦчЧшШщЩъЪыЫьЬэЭюЮяЯ]+$')
      .hasMatch(value);
}

DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

String makeSubstring(String? string, {int length = 35, String ending = '...'}) {
  if (string == null) return '';
  if (string.length > length) {
    return string.substring(0, length) + ending;
  } else
    return string;
}

//TODO: валидации на время и дату!!!
Future<DateTime?> selectDateTime(BuildContext context,
    {DateTime? initialDate}) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    locale: const Locale("ru"),
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 30)),
  );

  return _selectTime(context, selectedDate).then((value) => value);
}

//TODO: ограничение по времени, если выбран сегодняшний день
Future<DateTime?> _selectTime(
    BuildContext context, DateTime? selectedDate) async {
  DateTime? selectedDateTime = selectedDate;
  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: selectedDate != null
        ? TimeOfDay.fromDateTime(selectedDate)
        : TimeOfDay.fromDateTime(DateTime.now().toLocal()),
  );
  if (selectedTime != null) {
    int _hour = selectedTime.hour;
    int _minute = selectedTime.minute;
    selectedDateTime =
        selectedDate!.add(Duration(hours: _hour, minutes: _minute));
  }
  return selectedDateTime;
}

Future<DateTime?> selectDate(
    BuildContext context, DateTime? selectedDateTime) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    locale: const Locale("ru"),
    initialDate: selectedDateTime ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 30)),
  );

  return selectedDate;
}

String convertListToString(List<String> list, {String separator = ', '}) {
  String res = '';

  if (list == null || list.length == 0) return res;

  for (int i = 0; i < list.length; i++) {
    res = res + list[i] + ((i == list.length - 1) ? '' : separator);
  }

  return res;
}

String convertListToStringNullSafe(List<String?>? params,
    {String separator = ', '}) {
  String res = '';

  if (params != null) {
    final List<String> _params = params.whereType<String>().toList();

    if (_params.length > 1) {
      for (int i = 0; i < params.length; i++) {
        res += _params[i].toString();
        res += (i == _params.length - 1) ? '' : separator;
      }
    } else if (_params.length == 1) {
      res = _params[0].toString();
    }
  }

  return res;
}

String? convertTimeDoubleToString(double? time, {String prefix = ''}) {
  String res = "";

  if (time == null) return res;

  double _hour = time.floorToDouble();
  int _minute = ((time - _hour) * 60).round();

  res = _hour.toStringAsFixed(0) +
      ':' +
      (_minute < 10 ? '0' : '') +
      _minute.toString();

  res = prefix + res;

  return res;
}

bool isNullOrEmptyString(String? string) =>
    (string == null || string == '') ? true : false;

DateTime? tryExtractDate(dynamic arg) {
  if (arg == null) return null;

  DateTime? res;

  try {
    //res = DateTime.fromMillisecondsSinceEpoch(arg.millisecondsSinceEpoch);
    res = arg.toDate();
  } on NoSuchMethodError {
    res = DateTime.parse(arg);
  } catch (e) {
    print(e.toString());
    return null;
  }

  return res;
}

//TODO: сортировку мб прикрутить
List<DateTime> genListOfDates({int depth = 7}) {
  List<DateTime> res = [];

  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);

  for (int i = 0; i < depth; i++) {
    DateTime date = today.subtract(Duration(days: i));
    res.add(date);
  }

  return res;
}

List<String> genListOfDateStrings(int depth) {
  List<String> res = [];
  List<DateTime> tmp = genListOfDates(depth: depth);

  for (int i = 0; i < tmp.length; i++) {
    String dateFormatted = rusDateFormatter(tmp[i], fmt: DateFormats.DMMM);
    res.add(dateFormatted);
  }

  return res;
}

DateTime getDateStart(DateTime date) =>
    DateTime(date.year, date.month, date.day);

DateTime getDateEnd(DateTime date) =>
    DateTime(date.year, date.month, date.day).add(Duration(days: 1));

DateTime _lastMonday(DateTime date) =>
    DateTime(date.year, date.month, date.day - (date.weekday - 1));

DateTime _nextSunday(DateTime date) =>
    DateTime(date.year, date.month, date.day + date.weekday % 7);

DateTimeRange getWeekRange(DateTime date) =>
    DateTimeRange(start: _lastMonday(date), end: _nextSunday(date));
