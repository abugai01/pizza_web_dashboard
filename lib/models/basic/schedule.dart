// import 'package:vox_walker/helpers/rus_date_formatter.dart';
//
// class Schedule {
//   static const BEGIN_AT = 'beginAt';
//   static const END_AT = 'endAt';
//
//   DateTime beginAt;
//   DateTime endAt;
//
//   Schedule({required this.beginAt, required this.endAt});
//
//   static fromMap(Map<String, dynamic> data) {
//     final beginAt = DateTime.fromMillisecondsSinceEpoch(
//         data[BEGIN_AT].millisecondsSinceEpoch);
//     final endAt = DateTime.fromMillisecondsSinceEpoch(
//         data[END_AT].millisecondsSinceEpoch);
//
//     return Schedule(beginAt: beginAt, endAt: endAt);
//   }
//
//   Map<String, dynamic> toMap() {
//     return {BEGIN_AT: this.beginAt, END_AT: this.endAt};
//   }
//
//   String get beginAtString => generateDateText(this.beginAt, includeTime: true);
//
//   String get durationInMinutesText =>
//       this.endAt.difference(this.beginAt).inMinutes.toString() + ' ' + 'мин.';
//   String get durationInHoursText =>
//       this.endAt.difference(this.beginAt).inHours.toString() + ' ' + 'ч.';
//   String get durationInDaysText =>
//       this.endAt.difference(this.beginAt).inDays.toString() + ' ' + 'дн.';
// }
