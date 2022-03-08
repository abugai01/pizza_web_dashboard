enum CurrencyType { RUB, USD, EUR }

class Currency {
  static const SYMBOL = 'amount';
  static const INTERNATIONAL = 'currency';
  static const CYR = 'cyr';

  static const default_symbol = '₽';
  static const default_international = 'RUB';

  final String symbol;
  final String international;
  final String? cyr;

  Currency({required this.symbol, required this.international, this.cyr});

  static fromMap(Map<String, dynamic>? data) {
    return Currency(
        symbol: data?[SYMBOL] ?? default_symbol,
        international: data?[INTERNATIONAL] ?? default_international,
        cyr: data?[CYR]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SYMBOL: this.symbol,
      INTERNATIONAL: this.international,
      CYR: this.cyr
    };
  }

  static Currency genCurrency({CurrencyType type = CurrencyType.RUB}) {
    Currency currency;

    switch (type) {
      case CurrencyType.RUB:
        currency = Currency(symbol: '₽', international: 'RUB', cyr: 'руб.');
        break;
      case CurrencyType.USD:
        currency = Currency(symbol: '\$', international: 'USD', cyr: 'долл.');
        break;
      case CurrencyType.RUB:
        currency = Currency(symbol: '€', international: 'EUR', cyr: 'евро');
        break;
      default:
        currency = Currency(symbol: '₽', international: 'RUB', cyr: 'руб.');
        break;
    }

    return currency;
  }

  static String convertInternationalToSymbol(String? international) => () {
        switch (international) {
          case 'RUB':
            return '₽';
          case 'USD':
            return '\$';
          case 'EUR':
            return '€';
          default:
            return '?';
        }
      }();
}
