enum ExecutorAccessStatus { UNCHECKED, ALLOWED, DENIED, BLOCKED }

// UNCHECKED - не проверен
// ALLOWED - доступ разрешен
// DENIED - отказано в доступе (не прошел проверку)
// BLOCKED - заблокирован

enum ExecutorActivityStatus { AVAILABLE, BUSY, INACTIVE }

// AVAILABLE - активен (готов брать заказы)
// BUSY - занят в данный момент выполнением заказа
// INACTIVE - неактивен (не готов брать заказы, не нужно отправлять уведомления о новых)

class ExecutorConstants {
  static const Map<ExecutorAccessStatus, String> _access_status_to_string = {
    ExecutorAccessStatus.UNCHECKED: 'unchecked',
    ExecutorAccessStatus.ALLOWED: 'allowed',
    ExecutorAccessStatus.DENIED: 'denied',
    ExecutorAccessStatus.BLOCKED: 'blocked',
  };

  static const Map<String, ExecutorAccessStatus> _string_to_access_status = {
    'unchecked': ExecutorAccessStatus.UNCHECKED,
    'allowed': ExecutorAccessStatus.ALLOWED,
    'denied': ExecutorAccessStatus.DENIED,
    'blocked': ExecutorAccessStatus.BLOCKED,
  };

  static String? accessStatusToString(ExecutorAccessStatus? status) =>
      _access_status_to_string[status];
  static ExecutorAccessStatus? stringToAccessStatus(String? string) =>
      _string_to_access_status[string];

  static const Map<ExecutorActivityStatus, String> _activity_status_to_string =
      {
    ExecutorActivityStatus.AVAILABLE: 'available',
    ExecutorActivityStatus.BUSY: 'busy',
    ExecutorActivityStatus.INACTIVE: 'inactive',
  };

  static const Map<String, ExecutorActivityStatus> _string_to_activity_status =
      {
    'available': ExecutorActivityStatus.AVAILABLE,
    'busy': ExecutorActivityStatus.BUSY,
    'inactive': ExecutorActivityStatus.INACTIVE,
  };

  static String? activityStatusToString(ExecutorActivityStatus? status) =>
      _activity_status_to_string[status];
  static ExecutorActivityStatus? stringToActivityStatus(String? string) =>
      _string_to_activity_status[string];

  static Map<ExecutorAccessStatus, String> stopScreenText = {
    ExecutorAccessStatus.UNCHECKED:
        "Ваша кандидатура проверяется!\nМы сообщим вам о результатах проверки",
    ExecutorAccessStatus.ALLOWED: "Вы можете принимать и выполнять заказы",
    ExecutorAccessStatus.DENIED:
        "К сожалению, в данный момент вы не можем предложить вам работу выгульщиком. Мы свяжемся с вами позднее в случае обоюдного желания продолжать сотрудничество.",
    ExecutorAccessStatus.BLOCKED:
        "К сожалению, в данный момент вы не можете принимать заказы. Если вы считаете, что это ошибка, свяжитесь с нами в телеграме",
  };
}
