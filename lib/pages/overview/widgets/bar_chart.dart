/// Bar chart example
import 'package:charts_flutter/flutter.dart'
    as charts; //TODO: The library 'package:charts_flutter/flutter.dart' is legacy, and should not be imported into a null safe library.
import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/config/style.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate = false});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return charts.BarChart(
    //   seriesList, //TODO: здесь что-то серьезно изменилось,
    //   animate: animate,
    // );
    return Center(child: Text("что-то сломалось с переходом на null safety"));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('Today', 55),
      OrdinalSales('Yesterday', 25),
      OrdinalSales('2 days', 100),
      OrdinalSales('24 Jun', 75),
      OrdinalSales('23 Jun', 15),
      OrdinalSales('22 Jun', 85),
      OrdinalSales('21 Jun', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(active),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
