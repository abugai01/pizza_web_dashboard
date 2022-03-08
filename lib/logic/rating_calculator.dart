//TODO: протестить
//TODO: обработать пустой массив
import 'package:flutter/cupertino.dart';

class RatingCalculator {
  static const int depthLimit = 25;

  //Подразумевается, что массив уже отсортирован //TODO: сортировка!
  static double calculateAverageRating(List<num> values) {
    //TODO: null safe
    List<num> _values = [];
    int _length = (values.length > depthLimit) ? depthLimit : values.length;
    _values =
        (values.length > depthLimit) ? values.sublist(0, depthLimit) : values;

    double result = _values.map((val) => val).reduce((a, b) => a + b) /
        _length; //TODO: cast as double?
    return result;
  }

  // Во столько раз вес первой оценки больше, чем последней
  // Чем больше значение, тем выше значимость последних оценок
  // Вес оценки снижается равномерно по прямой
  static const double weightBias = 2;

  static double calculateAverageRatingVariant(List<num> values) {
    //TODO: null safe
    List<num> _values = [];
    int _length = (values.length > depthLimit) ? depthLimit : values.length;
    _values =
        (values.length > depthLimit) ? values.sublist(0, depthLimit) : values;

    List<double> weights = [];
    double lastWeight = 1;
    double firstWeight = 1 * weightBias;
    double weightDiff = firstWeight - lastWeight;
    for (int i = 0; i <= _length; i++) {
      double _weight = (i == 0)
          ? firstWeight
          : (firstWeight - weightDiff * i / (_length - 1));
      weights.add(_weight);
    }
    double totalWeight = weights.map((val) => val).reduce((a, b) => a + b);

    double result = 0;
    for (int i = 0; i < _length; i++) {
      result += _values[i] * weights[i];
    }
    result /= totalWeight;
    return result;
  }
}
