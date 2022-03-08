import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';
import 'package:pizza_web_dashboard/models/basic/currency.dart';

class Payment {
  static const ID = 'id';
  static const ORDER_ID = 'orderId';
  static const USER_ID = 'userId';
  static const SUM = 'sum';
  static const CURRENCY = 'currency';
  static const CREATED_AT = 'createdAt';
  static const UPDATED_AT = 'updatedAt';
  static const CHECKOUT_URL = 'checkoutUrl';
  static const STATUS = 'status';
  static const PAYMENT_ID = 'paymentId';

  String id;
  String? orderId;
  String? userId;
  num? sum;
  Currency? currency;
  //String? currency;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  String? paymentId;
  String? checkoutUrl;

  Payment({
    required this.id,
    this.orderId,
    this.userId,
    this.sum,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.paymentId,
    this.checkoutUrl,
  });

  static fromMap(Map<String, dynamic>? data, String documentId) {
    final currency = Currency.fromMap(data?[CURRENCY]);

    return Payment(
      id: documentId,
      orderId: data?[ORDER_ID],
      userId: data?[USER_ID],
      sum: data?[SUM],
      //currency: data?[CURRENCY],
      currency: currency,
      createdAt: tryExtractDate(data?[CREATED_AT]),
      updatedAt: tryExtractDate(data?[UPDATED_AT]),
      status: data?[STATUS],
      paymentId: data?[PAYMENT_ID],
      checkoutUrl: data?[CHECKOUT_URL],
    );
  }

  //Геттеры
  //String get sumFormatted => (this.sum == null) ? '?' : (this.sum!.toStringAsFixed(0) + ' ' + Currency.convertInternationalToSymbol(this.currency));
  String get sumFormatted => (this.sum == null || this.currency == null)
      ? '?'
      : (this.sum!.toStringAsFixed(0) + ' ' + this.currency!.symbol);
  String get createdAtFormatted =>
      rusDateFormatter(this.createdAt, fmt: DateFormats.DMMMYYYYHHMM);
  // String get createdAtFormattedDate =>
  //     rusDateFormatter(this.createdAt, fmt: DateFormats.DMMM);
  // String get createdAtFormattedTime =>
  //     rusDateFormatter(this.createdAt, fmt: DateFormats.HHMM);
  String get updatedAtFormatted =>
      rusDateFormatter(this.updatedAt, fmt: DateFormats.DMMMYYYYHHMM);
}
