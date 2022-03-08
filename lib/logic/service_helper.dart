enum ServiceType {
  walkingNow,
  walkingSubscription,
  sittingNanny,
  sittingBoarding,
  cynologistOnline,
  cynologistOffline,
  walkingScheduled, //Заказ выгула к определенному времени в рамках абонемента
}

class ServiceHelper {
  static const List<String> strings = [
    "walkingNow",
    "walkingSubscription",
    "sittingNanny",
    "sittingBoarding",
    "cynologistOnline",
    "cynologistOffline",
    "walkingScheduled",
  ];

  static const List<ServiceType> service_types = [
    ServiceType.walkingNow,
    ServiceType.walkingSubscription,
    ServiceType.sittingNanny,
    ServiceType.sittingBoarding,
    ServiceType.cynologistOnline,
    ServiceType.cynologistOffline,
    ServiceType.walkingScheduled,
  ];

  static const defaultServiceType = ServiceType.walkingNow;
  static const defaultString = "service_walkingNow";

  //Используется для экрана new_order, включает все услуги кроме walkingSchedule, потому что ее можно добавить только в рамках абонемента
  // static List<ServiceType> availableForOrderServiceTypes = [
  //   service_types[0],
  //   service_types[1],
  //   service_types[2],
  //   service_types[3],
  //   service_types[4],
  //   service_types[5]
  // ];

  static Map<String, ServiceType> _stringToServiceType = {
    // strings[0]: ServiceType.walkingNow,
    // strings[1]: ServiceType.walkingSubscription,
    // strings[2]: ServiceType.sittingNanny,
    // strings[3]: ServiceType.sittingBoarding,
    // strings[4]: ServiceType.cynologistOnline,
    // strings[5]: ServiceType.cynologistOffline,
    // strings[6]: ServiceType.walkingScheduled,
    strings[0]: service_types[0],
    strings[1]: service_types[1],
    strings[2]: service_types[2],
    strings[3]: service_types[3],
    strings[4]: service_types[4],
    strings[5]: service_types[5],
    strings[6]: service_types[6],
  };

  //TODO: может быть можно функцией перебора обойтись , а не три разных объекта map
  static Map<ServiceType, String> _serviceTypeToString = {
    // ServiceType.walkingNow: strings[0],
    // ServiceType.walkingSubscription: strings[1],
    // ServiceType.sittingNanny: strings[2],
    // ServiceType.sittingBoarding: strings[3],
    // ServiceType.cynologistOnline: strings[4],
    // ServiceType.cynologistOffline: strings[5],
    // ServiceType.walkingScheduled: strings[6],
    service_types[0]: strings[0],
    service_types[1]: strings[1],
    service_types[2]: strings[2],
    service_types[3]: strings[3],
    service_types[4]: strings[4],
    service_types[5]: strings[5],
    service_types[6]: strings[6],
  };

  static Map<ServiceType, String> _serviceTypeToTranslatedString = {
    // ServiceType.walkingNow: "Выгул сейчас",
    // ServiceType.walkingSubscription: "Абонемент на выгулы",
    // ServiceType.sittingNanny: "Дог-няня",
    // ServiceType.sittingBoarding: "Передержка",
    // ServiceType.cynologistOnline: "Кинолог онлайн",
    // ServiceType.cynologistOffline: "Кинолог оффлайн",
    // ServiceType.walkingScheduled: "Выгул по графику",
    service_types[0]: "Выгул сейчас",
    service_types[1]: "Абонемент на выгулы",
    service_types[2]: "Дог-няня",
    service_types[3]: "Передержка",
    service_types[4]: "Кинолог онлайн",
    service_types[5]: "Кинолог оффлайн",
    service_types[6]: "Выгул по графику",
  };

  static ServiceType stringToServiceType(String? id) {
    if (_stringToServiceType.containsKey(id)) {
      return _stringToServiceType[id]!;
    }
    return defaultServiceType;
  }

  static String serviceTypeToString(ServiceType? type) {
    if (_serviceTypeToString.containsKey(type)) {
      return _serviceTypeToString[type]!;
    }
    return defaultString;
    //TODO: по идее тут какое-то null значение нужно предусмотреть
  }

  static String serviceTypeToTranslatedString(ServiceType? type) {
    if (_serviceTypeToTranslatedString.containsKey(type)) {
      return _serviceTypeToTranslatedString[type]!;
    }
    return _serviceTypeToTranslatedString[
        defaultServiceType]!; //TODO: мб и null надо возвращать!
  }

  // static String stringToTranslatedString(String? id) {
  //   if (idToServiceType.containsKey(id)) {
  //     ServiceType? _type = idToServiceType[id];
  //     if (serviceTypeToName.containsKey(_type))
  //       return serviceTypeToName[_type]!;
  //   }
  //   return '';
  // }

}
