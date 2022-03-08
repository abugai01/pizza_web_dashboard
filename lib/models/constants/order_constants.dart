import 'package:pizza_web_dashboard/logic/order_helper.dart';
import 'package:pizza_web_dashboard/logic/service_helper.dart';

//TODO: сделать part of

enum OrderStatus {
  CREATING,
  PENDING,
  ACCEPTED,
  SEARCHING_FOR_EXECUTOR,
  EXECUTOR_FOUND,
  AWAITING_EXECUTOR,
  EXECUTING,
  AWAITING_FEEDBACK,
  FINISHED,
  CANCELLED,
  EXPIRED,
  ERROR //Статус-заглушка на случай какой-л. ошибки
}

class OrderConstants {
  static Map<int, String> durationOptionsInfo = {
    40: "40 мин.",
    60: "1 час",
    90: "1,5 часа"
  };

  static Map<String, double> sittingDurationLimits = {
    "min": 1.0,
    "max": 8.0,
  };
  static double? get minSittingDuration => sittingDurationLimits['min'];
  static double? get maxSittingDuration => sittingDurationLimits['max'];

  static const List<int> options_duration = [40, 60, 90];

  static const List<OrderStatus> options_status = [
    OrderStatus.CREATING, //Начальный статус для только что созданного заказа
    OrderStatus.PENDING, //Заказ не оплачен
    OrderStatus.ACCEPTED, //Заказ оплачен
    OrderStatus
        .SEARCHING_FOR_EXECUTOR, //Поиск исполнителя //TODO: похоже что лишний статус сейчас
    OrderStatus
        .EXECUTOR_FOUND, //Исполнитель найден, но приступать к заказу еще рано (релевантно для заказов заранее)
    OrderStatus.AWAITING_EXECUTOR, //Исполнитель в пути
    OrderStatus.EXECUTING, //Заказ в процессе выполнения
    OrderStatus.AWAITING_FEEDBACK, //Ожидает выставления оценки
    OrderStatus.FINISHED, //Выполнен
    OrderStatus.CANCELLED, //Отменен
    OrderStatus
        .EXPIRED, //Истек срок ожидания (мы так и не смогли найти исполнителя)
    OrderStatus.ERROR,
  ];

  static const List<String> options_status_string = [
    'creating', //Начальный статус для только что созданного заказа
    'pending', //Заказ не оплачен
    'accepted', //Заказ оплачен
    'searchingForExecutor', //Поиск исполнителя //TODO: похоже что лишний статус сейчас
    'executorFound', //Исполнитель найден, но приступать к заказу еще рано (релевантно для заказов заранее)
    'awaitingExecutor', //Исполнитель в пути
    'executing', //Заказ в процессе выполнения
    'awaitingFeedback', //Ожидает выставления оценки
    'finished', //Выполнен
    'cancelled', //Отменен
    'expired', //Истек срок ожидания (мы так и не смогли найти исполнителя)
    'error',
  ];

  //Список статусов для формирования списка прошлых заказов
  static const List<OrderStatus> finished_statuses = [
    OrderStatus.AWAITING_FEEDBACK,
    OrderStatus.FINISHED,
    OrderStatus.CANCELLED,
    OrderStatus.EXPIRED,
  ];
  //Список статусов для формирования списка актуальных заказов
  static const List<OrderStatus> actual_statuses = [
    //OrderStatus.PENDING,
    //OrderStatus.ACCEPTED,
    //OrderStatus.SEARCHING_FOR_EXECUTOR,
    OrderStatus.EXECUTOR_FOUND,
    OrderStatus.AWAITING_EXECUTOR,
    OrderStatus.EXECUTING,
  ];
  static const List<OrderStatus> cancellable_statuses = [
    OrderStatus.EXECUTOR_FOUND,
    OrderStatus.AWAITING_EXECUTOR,
  ];
  static const List<OrderStatus> assignable_statuses = [
    //TODO: включить сюда логику с оплатой после нахождения выгульщика
    OrderStatus.CREATING,
    OrderStatus.PENDING,
    OrderStatus.ACCEPTED,
    OrderStatus.SEARCHING_FOR_EXECUTOR,
  ];
  static const List<OrderStatus> active_statuses = [
    OrderStatus.AWAITING_EXECUTOR,
    OrderStatus.EXECUTING,
  ];
  static const List<OrderStatus> cancelled_statuses = [
    OrderStatus.CANCELLED,
    OrderStatus.EXPIRED,
  ];
  static const List<OrderStatus> waiting_statuses = [
    OrderStatus.CREATING,
    OrderStatus.PENDING,
    OrderStatus.ACCEPTED,
    OrderStatus.SEARCHING_FOR_EXECUTOR,
  ];
  static List<String?>? get actualStatuses =>
      actual_statuses.map((val) => OrderHelper.statusToString(val)).toList();

  //Важно, чтобы эти параметры были прописаны в таком виде в ценовой модели
  static const Map<ServiceType, List<String>> options_additionalServices = {
    ServiceType.walkingNow: ['Помыть лапы', 'Почесать пузико'],
    ServiceType.walkingSubscription: ['Помыть лапы'],
    ServiceType.sittingNanny: ['Покормить'],
    ServiceType.sittingBoarding: ['Покормить', 'Дополнительный выгул'],
    ServiceType.cynologistOnline: [],
    ServiceType.cynologistOffline: [],
    ServiceType.walkingScheduled: ['Помыть лапы', 'Покормить'],
  };

  static const List<int> options_subscriptionQuantity = [10, 30];

  //Дефолтные значения
  static int defaultDuration = options_duration[0];
  static int defaultNumberOfWalks = options_subscriptionQuantity[0];
  static String defaultStatus = options_status_string[0];
  static double defaultSittingDuration = 4.0;
}
