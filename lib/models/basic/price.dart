import 'package:pizza_web_dashboard/models/basic/currency.dart';

enum PriceType { Customer, Executor }

class Price {
  static const CUSTOMER = 'customer';
  static const EXECUTOR = 'executor';
  static const CURRENCY = 'currency';
  static const CITY = 'city';

  final num? customer;
  final num? executor;
  final Currency? currency;
  final String? city;

  Price({this.customer, this.executor, this.currency, this.city});

  static fromMap(Map<String, dynamic>? data) {
    final Currency currency = Currency.fromMap(data?[CURRENCY]);

    return Price(
      customer: data?[CUSTOMER],
      executor: data?[EXECUTOR],
      currency: currency,
      city: data?[CITY],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CUSTOMER: this.customer,
      EXECUTOR: this.executor,
      CURRENCY: this.currency,
      CITY: this.city,
    };
  }

  String? get customerPriceString =>
      (customer == null) ? null : priceString(customer!);
  String? get executorPriceString =>
      (executor == null) ? null : priceString(executor!);
  num? get profit =>
      (customer == null || executor == null) ? null : (customer! - executor!);
  String? get profitString => (profit == null) ? null : priceString(profit!);

  String priceString(num price, {String symbol = Currency.default_symbol}) =>
      price.toStringAsFixed(0) + ' ' + symbol;
  num? priceByType(PriceType type) =>
      (type == PriceType.Customer) ? customer : executor;
  String getBothPricesString({String separator = ' · '}) =>
      customerPriceString.toString() +
      separator +
      executorPriceString.toString();
}
