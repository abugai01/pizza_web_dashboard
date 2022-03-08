import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';

enum DistanceCalculationType { FromMyAddress, FromCurrentPosition }

class CustomFilter {
  static const MAX_DISTANCE = 'maxDistance';
  static const MIN_TIME = 'minTime';
  static const MAX_TIME = 'maxTime';
  static const IS_UNLIMITED_DISTANCE = 'isUnlimitedDistance';
  static const DISTANCE_CALCULATION_TYPE = 'distanceCalculationType';

  //Для SharedPreferences
  static const MIN_TIME_MILLISECONDS = 'minTimeMilliseconds';
  static const MAX_TIME_MILLISECONDS = 'maxTimeMilliseconds';
  static const DISTANCE_CALCULATION_TYPE_INT = 'distanceCalculationTypeInt';

  double? _maxDistance;
  DateTime? _minTime;
  DateTime? _maxTime;
  bool isUnlimitedDistance;
  DistanceCalculationType distanceCalculationType;

  double get maxDistance => (_maxDistance != null)
      ? _maxDistance!
      : isUnlimitedDistance
          ? unlimitedMaxDistance
          : defaultMaxDistance;
  DateTime get minTime => (_minTime != null) ? _minTime! : DateTime.now();
  DateTime get maxTime => (_maxTime != null) ? _maxTime! : DateTime(2100);

  set maxDistance(double val) => _maxDistance = val;
  set minTime(DateTime val) => _minTime = val;
  set maxTime(DateTime val) => _maxTime = val;

  static double defaultMaxDistance = 10.0;
  static double unlimitedMaxDistance = 50.0;
  static double minChoosableDistance = 5.0;
  static double maxChoosableDistance = 25.0;
  static int defaultHoursFromNow = 3;
  static String nullText = "Не указано";

  CustomFilter(
      {double? maxDistance,
      DateTime? minTime,
      DateTime? maxTime,
      isUnlimitedDistance = false,
      distanceCalculationType = DistanceCalculationType.FromCurrentPosition})
      : this.isUnlimitedDistance = isUnlimitedDistance,
        this.distanceCalculationType = distanceCalculationType {
    this._maxDistance = maxDistance;
    this._minTime = minTime;
    this._maxTime = maxTime;
    //this.isUnlimitedDistance = isUnlimitedDistance;
    //this.distanceCalculationType = distanceCalculationType;
  }

  CustomFilter.defaultValues()
      : _maxDistance = defaultMaxDistance,
        _minTime = DateTime.now(),
        _maxTime = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour + defaultHoursFromNow),
        isUnlimitedDistance = false,
        distanceCalculationType = DistanceCalculationType.FromCurrentPosition;

  CustomFilter copy(
      {double? maxDistance,
      DateTime? minTime,
      DateTime? maxTime,
      bool? isUnlimitedDistance,
      DistanceCalculationType? distanceCalculationType}) {
    return CustomFilter(
      maxDistance: maxDistance == null ? this.maxDistance : maxDistance,
      minTime: minTime == null ? this.minTime : minTime,
      maxTime: maxTime == null ? this.maxTime : maxTime,
      isUnlimitedDistance: isUnlimitedDistance == null
          ? this.isUnlimitedDistance
          : isUnlimitedDistance,
      distanceCalculationType: distanceCalculationType == null
          ? this.distanceCalculationType
          : distanceCalculationType,
    );
  }

  String get minTimeString => (_minTime != null)
      ? generateDateText(_minTime!, includeTime: true)
      : nullText;
  String get maxTimeString => (_maxTime != null)
      ? generateDateText(_maxTime!, includeTime: true)
      : nullText;
  // String get maxDistanceString => (_maxDistance != null)
  //     ? _maxDistance!.toStringAsFixed(1) + ' км'
  //     : nullText;
  String get maxDistanceString => maxDistance.toStringAsFixed(1) + ' км';
}
