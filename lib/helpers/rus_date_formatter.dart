import 'dart:convert';
import 'package:intl/intl.dart';

enum DateFormats {
  DMMMYYYY,
  DMMM,
  EE,
  EEEE,
  EEEEDMMM,
  HHMM,
  DMMMYYYYHHMM,
}

//Локализация дат с помощью библиотеки intl: https://flutteragency.com/how-to-load-all-dart-dateformat-locale-in-flutter/

String rusDateFormatter(DateTime? _date,
    {DateFormats fmt = DateFormats.DMMMYYYY}) {
  String res;
  //DateTime _date = DateTime.tryParse(date);

  if (_date == null) {
    return "";
  }

  dynamic dayData =
      '{ "1" : "Пн", "2" : "Вт", "3" : "Ср", "4" : "Чт", "5" : "Пт", "6" : "Сб", "7" : "Вс" }';
  dynamic dayDataFull =
      '{ "1" : "Понедельник", "2" : "Вторник", "3" : "Среда", "4" : "Четверг", "5" : "Пятница", "6" : "Суббота", "7" : "Воскресенье" }';
  dynamic dayDataStartingFromSunday =
      '{ "1" : "Вс", "2" : "Пн", "3" : "Вт", "4" : "Ср", "5" : "Чт", "6" : "Пт", "7" : "Сб" }';
  dynamic dayDataStartingFromSundayFull =
      '{ "1" : "Воскресенье", "2" : "Понедельник", "3" : "Вторник", "4" : "Среда", "5" : "Четверг", "6" : "Пятница", "7" : "Суббота" }';
  dynamic dayDataStartingFromSundayZero =
      '{ "0" : "Вс", "1" : "Пн", "2" : "Вт", "3" : "Ср", "4" : "Чт", "5" : "Пт", "6" : "Сб" }';
  dynamic dayDataStartingFromSundayZeroFull =
      '{ "0" : "Воскресенье", "1" : "Понедельник", "2" : "Вторник", "3" : "Среда", "4" : "Четверг", "5" : "Пятница", "6" : "Суббота" }';
  dynamic monthData =
      '{ "1" : "Янв", "2" : "Фев", "3" : "Мар", "4" : "Апр", "5" : "Май", "6" : "Июн", "7" : "Июл", "8" : "Авг", "9" : "Сен", "10" : "Окт", "11" : "Ноя", "12" : "Дек" }';
  dynamic monthDataFull =
      '{ "1" : "Январь", "2" : "Февраль", "3" : "Март", "4" : "Апрель", "5" : "Май", "6" : "Июнь", "7" : "Июль", "8" : "Август", "9" : "Сентябрь", "10" : "Октябрь", "11" : "Ноябрь", "12" : "Декабрь" }';
  dynamic monthDataFullPossessive =
      '{ "1" : "января", "2" : "февраля", "3" : "марта", "4" : "апреля", "5" : "мая", "6" : "июня", "7" : "июля", "8" : "августа", "9" : "сентября", "10" : "октября", "11" : "ноября", "12" : "декабря" }';

  /*
  return json.decode(dayData)['${date.weekday}'] +
      ", " +
      date.day.toString() +
      " " +
      json.decode(monthData)['${date.month}'] +
      " " +
      date.year.toString();
    */

  switch (fmt) {
    case DateFormats.DMMM:
      res = _date.day.toString() +
          " " +
          json.decode(monthDataFullPossessive)['${_date.month}'];
      break;
    case DateFormats.DMMMYYYY:
      res = _date.day.toString() +
          " " +
          json.decode(monthDataFullPossessive)['${_date.month}'] +
          ", " +
          _date.year.toString();
      break;
    case DateFormats.EEEE:
      res = json.decode(dayDataStartingFromSunday)['${_date.weekday}'];
      break;
    case DateFormats.EEEE:
      res = json.decode(dayDataStartingFromSundayFull)['${_date.weekday}'];
      break;
    case DateFormats.HHMM:
      res = DateFormat('HH:mm').format(_date).toString();
      break;
    case DateFormats.EEEEDMMM:
      res = json.decode(dayDataFull)['${_date.weekday}'] +
          ', ' +
          _date.day.toString() +
          " " +
          json.decode(monthDataFullPossessive)['${_date.month}'];
      break;
    case DateFormats.DMMMYYYYHHMM:
      res = DateFormat('dd.MM.yyyy HH:mm').format(_date).toString();
      break;
    default:
      res = DateFormat('dd.MM.yyyy').format(_date).toString();
  }

  return res;
}

String convertWeekdaysArrayToString(List<int> weekdaysList) {
  dynamic dayDataStartingFromSunday =
      '{ "1" : "Вс", "2" : "Пн", "3" : "Вт", "4" : "Ср", "5" : "Чт", "6" : "Пт", "7" : "Сб" }';
  dynamic dayDataStartingFromMonday =
      '{ "1" : "Пн", "2" : "Вт", "3" : "Ср", "4" : "Чт", "5" : "Пт", "6" : "Сб", "7" : "Вс" }';

  String res = "";

  for (int i = 1; i <= weekdaysList.length; i++) {
    res = res +
        json.decode(dayDataStartingFromMonday)['${weekdaysList[i - 1]}'] +
        ((i == weekdaysList.length) ? '' : ', ');
  }
  return res;
}

String generateDateText(DateTime? date, {bool includeTime = false}) {
  String res = '';
  if (date == null) return res;

  res = rusDateFormatter(date, fmt: DateFormats.DMMM);

  if (!includeTime)
    return res;
  else
    return res + ' в ' + rusDateFormatter(date, fmt: DateFormats.HHMM);
}

String? generateWeekdaysText(List<int>? weekdays) {
  if (weekdays == null) return "";
  return "Еженедельно по " + convertWeekdaysArrayToString(weekdays);
}

//TODO: обрабатывать не только мужской род и числа вроде 111 и т.п.
String changeNounAccordingToNumber(String noun, int number,
    {String genitiveEnding = 'ов'}) {
  String ending = '';

  // 1 час, 21 час, 91 час (НО 11 часов!!!)
  if (number % 10 == 1 && number != 11) {
  }
  // 0,5,6,7,8,9,10 часов (+ числа от 11 до 19)
  else if ([0, 5, 6, 7, 8, 9].contains(number % 10) ||
      (number >= 11 && number <= 19)) {
    ending = genitiveEnding;
  }
  // 2, 3, 4 часа
  else if ([2, 3, 4].contains(number % 10)) {
    ending = 'а';
  }

  return noun + ending;
}

String getCorrectYearNoun(int years) {
  String res = '';
  String noun1 = ' год';
  String noun2 = ' лет';

  // 1 год, 21 год, 91 год (НО 11 лет!!!)
  // 2,3,4, 22, 34, 63 года
  if ((years % 10 == 1 && years != 11) || [2, 3, 4].contains(years % 10)) {
    res = changeNounAccordingToNumber(noun1, years);
  }
  // 0,5,6,7,8,9,10 лет (а также от 11 до 19)
  else if ([0, 5, 6, 7, 8, 9].contains(years % 10) ||
      (years >= 11 && years <= 19)) {
    res = noun2;
  }

  return years.toString() + res;
}

String getCorrectAgeNoun(int months) {
  String res = '';

  //Если более 2 лет, то уже не так важно, сколько месяцев
  if (months >= 24)
    res = getCorrectYearNoun(months ~/ 12);
  //Если от года до двух, то уточняем на всякий, сколько месяцев
  else if (months >= 12 && months < 24) {
    int residualMonths = months - 12;
    res = getCorrectYearNoun(1);

    //Если собаке 1 год 0 месяцев, то напишем просто "1 год"
    if (residualMonths > 0) {
      res += (' ' +
          residualMonths.toString() +
          changeNounAccordingToNumber(" месяц", residualMonths,
              genitiveEnding: 'ев'));
    }
  }
  //Если питомцу менее года, то напишем просто количество месяцев
  else if (months < 12) {
    res = months.toString() +
        changeNounAccordingToNumber(" месяц", months, genitiveEnding: 'ев');
  }

  return res;
}
