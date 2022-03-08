class APIPath {
  static String users() => 'users';
  static String user(String userId) => 'users/$userId';
  static String userAddresses(String userId) => 'users/$userId/addresses';
  static String userPets(String userId) => 'users/$userId/pets';
  static String userSubscriptions(String userId) =>
      'users/$userId/subscriptions';

  static String executors() => 'executors';
  static String executor(String? executorId) => 'executors/$executorId';
  // static String executorProfile(String? executorId) =>
  //     'executors/$executorId/profile';
  static String executorAddresses(String? executorId) =>
      'executors/$executorId/addresses';
  static String executorAddress(String? executorId, String? addressId) =>
      'executors/$executorId/addresses/$addressId';
  static String executorReviews(String? executorId) =>
      'executors/$executorId/vote'; //'executors/$executorId/reviews'; //TODO: поправить славину опечатку
  // static String executorReview(String? executorId, String? reviewId) =>
  //     'executors/$executorId/reviews/$reviewId';

  static String pet(String? uid, String? id) => 'users/$uid/pets/$id';
  static String pets(String? uid) => 'users/$uid/pets';
  static String petTypes() => 'petType';
  static String breeds(String? typeId) => 'petType/$typeId/breeds';
  static String aggressions() => 'aggressions';
  static String behaviorProblems() => 'behaviorProblems';
  static String fears() => 'fears';

  static String orders() => 'orders';
  static String order(String id) => 'orders/$id';
  static String orderItems(String? orderId) => 'orders/$orderId/items';

  static String chat(String chatId) => 'chats/$chatId';
  static String message(String chatId) => 'chats/$chatId/messages';

  static String addresses(String? uid) => 'users/$uid/addresses';

  static String payments() => 'payments';
  static String payment(String paymentId) => 'payments/$paymentId';

  static String admins() => 'admins';
  static String admin(String id) => 'admins/$id';

  static String telegramMessages() => 'telegramMessages';
}
