import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';

class Address {
  static const ID = "id";
  static const USER_ID = "userId"; //TODO: убрать наверное уже можно!
  static const LAT = "lat";
  static const LNG = "lng";
  static const TITLE = "title";
  static const DESCRIPTION = "description";
  static const ENTRANCE = "entrance";
  static const INTERCOM = "intercom";
  static const APARTMENT = "apartment";
  static const FLOOR = "floor";
  static const COMMENT = "comment";
  static const IS_MAIN = "isMain";
  static const CITY = "city";
  //TODO: сделать определение города! это нужно для расчета цены

  static const home = "Дом";
  static const work = "Работа";
  //Координаты центра Москвы в качестве заглушки вместо null
  static const DEFAULT_LAT = 55.751244; //TODO: наверное убрать надо!
  static const DEFAULT_LNG = 37.618423;

  String? id; //TODO: оно должно быть обязательное! подумать!
  //String? userId;
  double? lat;
  double? lng;
  String? title;
  String? description;
  bool? isMain;
  String? city;
  String? entrance;
  String? intercom;
  String? apartment;
  String? floor;
  String? comment;

  Address({
    required this.id,
    //this.userId,
    required this.lat,
    required this.lng,
    this.title,
    required this.description,
    this.isMain = false,
    this.city,
    this.entrance,
    this.intercom,
    this.apartment,
    this.floor,
    this.comment,
  });

  //TODO: что с городом по умолчанию? надо решить
  Address.fromMap(Map<String, dynamic>? data, String? documentId) {
    id = data?[ID] ?? documentId;
    lat = data?[LAT];
    lng = data?[LNG];
    description = data?[DESCRIPTION] ?? '';
    city = data?[CITY];
    isMain = data?[IS_MAIN] ?? false;
    //userId = data[USER_ID];
    //lat = data[LAT] ?? DEFAULT_LAT;
    //lng = data[LNG] ?? DEFAULT_LNG;
    title = data?[TITLE];
    //description = data[DESCRIPTION] ?? '';
    //isMain = data[IS_MAIN] ?? false;
    entrance = data?[ENTRANCE];
    intercom = data?[INTERCOM];
    apartment = data?[APARTMENT];
    floor = data?[FLOOR];
    comment = data?[COMMENT];
  }

  // Address.fromSnapshot(DocumentSnapshot snapshot)
  //     : lat = DEFAULT_LATб
  //       lng = DEFAULT_LNG,
  //       description = '',
  //       city = Cities.OTHER,
  //       isMain = false {
  //   id = snapshot.id;
  //   userId = extractFromSnapshot(snapshot, USER_ID) ?? "";
  //   lat = extractFromSnapshot(snapshot, LAT) ?? DEFAULT_LAT;
  //   lng = extractFromSnapshot(snapshot, LNG) ?? DEFAULT_LNG;
  //   title = extractFromSnapshot(snapshot, TITLE) ?? "";
  //   description = extractFromSnapshot(snapshot, DESCRIPTION) ?? "";
  //   entrance = extractFromSnapshot(snapshot, ENTRANCE) ?? "";
  //   intercom = extractFromSnapshot(snapshot, INTERCOM) ?? "";
  //   apartment = extractFromSnapshot(snapshot, APARTMENT) ?? "";
  //   floor = extractFromSnapshot(snapshot, FLOOR) ?? "";
  //   comment = extractFromSnapshot(snapshot, COMMENT) ?? "";
  //   isMain = extractFromSnapshot(snapshot, IS_MAIN) ?? false;
  //   city = extractFromSnapshot(snapshot, CITY) ?? "";
  // }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    //data[Address.ID] = id; //TODO: точно не нужно?
    //data[Address.USER_ID] = userId;
    data[Address.LAT] = lat;
    data[Address.LNG] = lng;
    data[Address.TITLE] = title;
    data[Address.DESCRIPTION] = description;
    data[Address.ENTRANCE] = entrance;
    data[Address.INTERCOM] = intercom;
    data[Address.APARTMENT] = apartment;
    data[Address.FLOOR] = floor;
    data[Address.COMMENT] = comment;
    data[Address.IS_MAIN] = isMain;
    data[Address.CITY] = city;

    return data;
  }

  //TODO: то хрень, надо убирать! особенно генерацию id. Или не убирать. Подумать короче
  // Address.empty({bool isMain = false})
  //     : lat = 0.0,
  //       lng = 0.0,
  //       description = '',
  //       city = City.Other,
  //       isMain = isMain,
  //       id = Uuid().v1() {
  //   //userId = userId;
  //   //lat = DEFAULT_LAT;
  //   //lng = DEFAULT_LNG;
  //   title = '';
  //   description = '';
  //   //isMain = false;
  //   //city = Cities.OTHER;
  // }

  Address copy({
    double? lat,
    double? lng,
    String? title,
    String? description,
    bool? isMain,
    String? city,
    String? entrance,
    String? intercom,
    String? apartment,
    String? floor,
    String? comment,
  }) {
    Address newAddress = Address(
      id: this.id,
      lat: (lat == null) ? this.lat : lat,
      lng: (lng == null) ? this.lng : lng,
      title: (title == null) ? this.title : title,
      description: isNullOrEmptyString(description)
          ? this.description
          : description!, //TODO: надо ли? может просто сравнивать с null?
      isMain: (isMain == null) ? this.isMain : isMain,
      city: (city == null) ? this.city : city,
      entrance: (entrance == null) ? this.entrance : entrance,
      intercom: (intercom == null) ? this.intercom : intercom,
      apartment: (apartment == null) ? this.apartment : apartment,
      floor: (floor == null) ? this.floor : floor,
      comment: (comment == null) ? this.comment : comment,
    );

    return newAddress;
  }

  String get entranceText => (entrance != null) ? "Подъезд: " + entrance! : '';
  String get intercomText => (intercom != null) ? "Домофон: " + intercom! : '';
  String get apartmentText =>
      (apartment != null) ? "Квартира: " + apartment! : '';
  String get floorText => (floor != null) ? "Этаж: " + floor! : '';
  String get shortDescription => makeSubstring(description, length: 25);
  LatLng? get position =>
      (lat == null || lng == null) ? null : LatLng(lat!, lng!);
}

class AddressConstants {
  static Map<String, String> addressElements = {
    Address.TITLE: "Название",
    Address.DESCRIPTION: "Адрес",
    Address.ENTRANCE: "Подъезд",
    Address.INTERCOM: "Домофон",
    Address.APARTMENT: "Квартира, офис",
    Address.FLOOR: "Этаж",
    Address.COMMENT: "Комментарий",
  };

  static String translate(String attribute) {
    return addressElements.containsKey(attribute)
        ? addressElements[attribute]!
        : '';
  }
}
