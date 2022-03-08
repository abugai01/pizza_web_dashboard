import 'package:pizza_web_dashboard/models/constants/order_constants.dart';

//TODO: сделать part of

class OrderHelper {
  static const Map<String, OrderStatus> string_to_status = {
    'creating': OrderStatus.CREATING,
    'pending': OrderStatus.PENDING,
    'accepted': OrderStatus.ACCEPTED,
    'searchingForExecutor': OrderStatus.SEARCHING_FOR_EXECUTOR,
    'executorFound': OrderStatus.EXECUTOR_FOUND,
    'awaitingExecutor': OrderStatus.AWAITING_EXECUTOR,
    'executing': OrderStatus.EXECUTING,
    'awaitingFeedback': OrderStatus.AWAITING_FEEDBACK,
    'finished': OrderStatus.FINISHED,
    'cancelled': OrderStatus.CANCELLED,
    'expired': OrderStatus.EXPIRED,
    'error': OrderStatus.ERROR,
  };

  static const Map<OrderStatus, String> status_to_string = {
    OrderStatus.CREATING: 'creating',
    OrderStatus.PENDING: 'pending',
    OrderStatus.ACCEPTED: 'accepted',
    OrderStatus.SEARCHING_FOR_EXECUTOR: 'searchingForExecutor',
    OrderStatus.EXECUTOR_FOUND: 'executorFound',
    OrderStatus.AWAITING_EXECUTOR: 'awaitingExecutor',
    OrderStatus.EXECUTING: 'executing',
    OrderStatus.AWAITING_FEEDBACK: 'awaitingFeedback',
    OrderStatus.FINISHED: 'finished',
    OrderStatus.CANCELLED: 'cancelled',
    OrderStatus.EXPIRED: 'expired',
    OrderStatus.ERROR: 'error'
  };

  static const Map<OrderStatus, String> status_to_translated_string = {
    OrderStatus.CREATING: "Создан", //TODO: навести порядок
    OrderStatus.PENDING: "Ждет оплаты",
    OrderStatus.ACCEPTED: "Принят",
    OrderStatus.SEARCHING_FOR_EXECUTOR: "Поиск исполнителя",
    OrderStatus.EXECUTOR_FOUND: "Исполнитель найден",
    OrderStatus.AWAITING_EXECUTOR: "Исполнитель в пути",
    OrderStatus.EXECUTING: "В процессе",
    OrderStatus.AWAITING_FEEDBACK: "Ждем оценку",
    OrderStatus.FINISHED: "Завершен",
    OrderStatus.CANCELLED: "Отменен",
    OrderStatus.EXPIRED: "Истек",
    OrderStatus.ERROR: "Ошибка",
  };

// Map<String, OrderStatus> textToStatusEnum = {
//   "Создан": OrderStatus.PENDING,
//   "Принят": OrderStatus.ACCEPTED,
//   "Поиск исполнителя": OrderStatus.SEARCHING_FOR_EXECUTOR,
//   "Ожидание исполнителя": OrderStatus.AWAITING_EXECUTOR,
//   "Исполнитель найден": OrderStatus.EXECUTOR_FOUND,
//   "В процессе": OrderStatus.EXECUTING,
//   "Поставьте оценку": OrderStatus.AWAITING_FEEDBACK,
//   "Завершен": OrderStatus.FINISHED,
//   "Отменен": OrderStatus.CANCELLED,
//   "Истек": OrderStatus.EXPIRED,
//   "Ошибка": OrderStatus.ERROR,
// };

  static String statusToTranslatedString(OrderStatus? status) {
    if (status_to_translated_string.containsKey(status)) {
      return status_to_translated_string[status]!;
    }
    return '';
  }

  static OrderStatus stringToStatus(String? string) {
    if (string_to_status.containsKey(string)) {
      return string_to_status[string]!;
    }
    return OrderStatus.ERROR;
  }

  static String? statusToString(OrderStatus? status) {
    if (status_to_string.containsKey(status)) {
      return status_to_string[status]!;
    }
    return null;
  }

  //TODO: используется ли?
  static List<String> getStatusesList({bool isTranslated = false}) {
    List<String> list = [];

    if (isTranslated) {
      status_to_translated_string.forEach((key, value) {
        list.add(value);
      });
    } else {
      status_to_string.forEach((key, value) {
        list.add(value);
      });
    }

    return list;
  }

  // 'pending': OrderStatus.PENDING,
  // 'accepted': OrderStatus.ACCEPTED,
  // 'searchingForExecutor': OrderStatus.SEARCHING_FOR_EXECUTOR,
  // 'executorFound': OrderStatus.EXECUTOR_FOUND,
  // 'awaitingExecutor': OrderStatus.AWAITING_EXECUTOR,
  // 'executing': OrderStatus.EXECUTING,
  // 'awaitingFeedback': OrderStatus.AWAITING_FEEDBACK,
  // 'finished': OrderStatus.FINISHED,
  // 'cancelled': OrderStatus.CANCELLED,
  // 'expired': OrderStatus.EXPIRED,
  // 'error': OrderStatus.ERROR,

  static OrderStatus getNextStatus(OrderStatus currentStatus) {
    OrderStatus? nextStatus;

    switch (currentStatus) {
      case OrderStatus.CREATING:
        nextStatus = OrderStatus.PENDING;
        break;
      case OrderStatus.PENDING:
        nextStatus = OrderStatus.ACCEPTED;
        break;
      case OrderStatus.ACCEPTED:
        nextStatus = OrderStatus.SEARCHING_FOR_EXECUTOR;
        break;
      case OrderStatus.SEARCHING_FOR_EXECUTOR:
        nextStatus = OrderStatus.EXECUTOR_FOUND;
        break;
      case OrderStatus.EXECUTOR_FOUND:
        nextStatus = OrderStatus.AWAITING_EXECUTOR;
        break;
      case OrderStatus.AWAITING_EXECUTOR:
        nextStatus = OrderStatus.EXECUTING;
        break;
      case OrderStatus.EXECUTING:
        nextStatus = OrderStatus.AWAITING_FEEDBACK;
        break;
      case OrderStatus.AWAITING_FEEDBACK:
        nextStatus = OrderStatus.FINISHED;
        break;
      default:
        nextStatus = OrderStatus.ERROR;
    }

    return nextStatus;
  }

  static String getCurrentScreenButtonText(OrderStatus? status) {
    String text = '';

    if (status == OrderStatus.EXECUTOR_FOUND)
      text = "Выезжаю на заказ!";
    else if (status == OrderStatus.AWAITING_EXECUTOR)
      text = "Начинаю выполнение";
    else if (status == OrderStatus.EXECUTING) text = "Подтверждаю завершение";

    return text;
  }
}
