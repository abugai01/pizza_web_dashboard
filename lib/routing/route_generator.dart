import 'package:pizza_web_dashboard/routing/routes.dart';

enum Routes {
  //1
  overview,
  users,
  executors,
  orders,
  services,
  map,
  stats,
  payments,
  additional,
  auth,
  //2
  user,
  order,
  executor,
  executorsPayments,
  executorsUnallowed,
  //3
  userPets,
  userAddresses, //TODO: добавить в рауты!!
  executorReviews,
  orderMap,
  //4
  pet,
}

class RouteGenerator {
  static const _slash = '/';

  static String _concatenate(List<dynamic> args) {
    String res = '';
    for (int i = 0; i < args.length; i++) {
      res += args[i].toString();

      if (i != args.length - 1) res += _slash;
    }
    return res;
  }

  // Если генерим ссылки динамически, то проще передавать один id, чем указывать конкретно, что это за идентификатор
  // Если в ссылке 2 идентификатора (напр. pet), то очевидно это работать не может
  static String genLink(Routes route,
      {String? userId,
      String? petId,
      String? executorId,
      String? orderId,
      String? id}) {
    switch (route) {
      //1
      case Routes.overview:
        return _overview();
      case Routes.users:
        return _users();
      case Routes.orders:
        return _orders();
      case Routes.stats:
        return _stats();
      case Routes.payments:
        return _payments();
      case Routes.additional:
        return _additional();
      case Routes.auth:
        return _auth();
      case Routes.user:
        return _user(userId ?? id);
      case Routes.order:
        return _order(orderId ?? id);
      default:
        return _overview();
    }
  }

  //Ссылки из 1 части
  static String _overview() => overviewPageRoute;
  static String _users() => usersPageRoute;
  static String _executors() => executorsPageRoute;
  static String _orders() => ordersPageRoute;
  static String _services() => servicesPageRoute;
  static String _map() => mapPageRoute;
  static String _stats() => statsPageRoute;
  static String _payments() => paymentsPageRoute;
  static String _additional() => additionalPageRoute;
  static String _auth() => authPageRoute;

  //Ссылки из 2-х частей
  static String _user(String? userId) =>
      _concatenate([userIndividualPageRoute, userId]);

  static String _order(String? orderId) =>
      _concatenate([orderIndividualPageRoute, orderId]);

  static String _executor(String? executorId) =>
      _concatenate([executorIndividualPageRoute, executorId]);

  static String _executorsPayments() =>
      _concatenate([executorsPageRoute, paymentsPageRoute]);

  static String _executorsUnallowed() =>
      _concatenate([executorsPageRoute, unallowedPageRoute]);

  //Ссылки из 3-х частей
  static String _userPets(String? userId) =>
      _concatenate([userIndividualPageRoute, userId, petsPageRoute]);

  static String _executorReviews(String? executorId) =>
      _concatenate([executorIndividualPageRoute, executorId, reviewsPageRoute]);

  static String _orderMap(String? orderId) =>
      _concatenate([orderIndividualPageRoute, orderId, mapPageRoute]);

  //Ссылки из 4-х частей
  static String _pet(String? userId, String? petId) =>
      _concatenate([userIndividualPageRoute, userId, petsPageRoute, petId]);

//TODO: наверное должны быть какие-то обратные функции сразу?

}
