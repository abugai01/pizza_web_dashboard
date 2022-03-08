import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';

class Review {
  static const ID = "id";
  static const VALUE = "value";
  static const TEXT = "text";
  static const USER_ID = "userId";
  static const ORDER_ID = "orderId";
  static const CREATED_AT = "createdAt";

  String id;
  num? value;
  String? text;
  String? userId;
  String? orderId;
  DateTime? createdAt;

  Review(
      {required this.id,
      this.value,
      this.text,
      this.userId,
      this.orderId,
      this.createdAt});

  static fromMap(Map<String, dynamic>? data, String documentId) {
    final createdAt = tryExtractDate(data?[CREATED_AT]);

    return Review(
      id: documentId,
      value: data?[VALUE],
      text: data?[TEXT],
      userId: data?[USER_ID],
      orderId: data?[ORDER_ID],
      createdAt: createdAt,
    );
  }

// Map<String, dynamic> toMap() {
//   return <String, dynamic>{
//     //ID: this.id,
//     AMOUNT: this.amount,
//     TEXT: this.text,
//     USER_ID: this.userId,
//     CREATED_AT: this.createdAt,
//   };
// }

  String get createdAtFormatted =>
      rusDateFormatter(createdAt, fmt: DateFormats.DMMMYYYY);
  String? get valueString => (value == null) ? null : value!.toStringAsFixed(1);
}
