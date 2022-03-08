//import 'dart:html';
import 'package:pizza_web_dashboard/logic/order_helper.dart';
import 'package:pizza_web_dashboard/models/address.dart';
import 'package:pizza_web_dashboard/models/basic/payment.dart';
import 'package:pizza_web_dashboard/models/constants/order_constants.dart';
import 'package:pizza_web_dashboard/models/internal/admin.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/models/user.dart';
import 'package:pizza_web_dashboard/services/api_path.dart';
import 'package:pizza_web_dashboard/services/firestore_service.dart';

//String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

abstract class Database {
  //TODO: постепенная подгрузка!

  /////////////////////////////////////////// User
  Future<List<User>> getUsers();

  Future<User> getUser({required String userId});

  Future<List<Address>> getUserAddresses({required String userId});

  Future<List<Order>> getUserOrders({required String userId});

  /////////////////////////////////////////// Order
  Future<List<Order>> getOrders();

  Future<List<Order>> getOrdersByDates(
      {required DateTime start, required DateTime end});

  Stream<List<Order>> newOrdersStream();

  Future<Order> getOrder({required String orderId});

  Stream<Order> orderStream({required String orderId});

  // Future<void> updateOrderStatus(
  //     {required String orderId, required String status, String executorId}); //TODO: это должно войти в updateOrder
  Future<List<Order>> getExecutingOrders();

  Future<void> updateOrder(
      {required String orderId, required Map<String, dynamic> data});

  /////////////////////////////////////////// Payments
  Future<List<Payment>> getPayments();

  Future<Payment> getPayment({required String paymentId});

  /////////////////////////////////////////// Admin
  Future<Admin?> getAdmin({required String userId});

  Future<bool> validateAdmin({required String userId});
}

class FirestoreDatabase implements Database {
  //FirestoreDatabase({required this.uid}) : assert(uid != null);

  //final String uid;

  late String? _uid;

  set uid(String value) => this._uid = value;

  String get uid => this._uid ?? '';

  final _service = FirestoreService.instance;

  /////////////////////////////////////////// User

  @override
  Future<List<User>> getUsers() => _service.getCollection(
        path: APIPath.users(),
        builder: (data, documentId) {
          return User.fromMap(data, documentId);
        },
      );

  @override
  Future<User> getUser({required String userId}) => _service.getDocument(
      path: APIPath.user(userId),
      builder: (data, documentId) => User.fromMap(data, documentId));

  @override
  Future<List<Address>> getUserAddresses({required String userId}) {
    return _service.getCollection(
      path: APIPath.userAddresses(userId),
      builder: (data, documentId) => Address.fromMap(data, documentId),
    );
  }

  @override
  Future<List<Order>> getUserOrders({required String userId}) =>
      _service.getCollection(
        path: APIPath.orders(),
        builder: (data, documentId) {
          return Order.fromMap(data, documentId);
        },
        queryBuilder: (query) => query.where(Order.USER_ID, isEqualTo: userId),
        sort: (a, b) =>
            (b.beginAt ?? DateTime(0)).compareTo(a.beginAt ?? DateTime(0)),
      );

  /////////////////////////////////////////// Order

  @override
  Future<List<Order>> getOrders() => _service.getCollection(
        path: APIPath.orders(),
        builder: (data, documentId) {
          return Order.fromMap(data, documentId);
        },
        // queryBuilder: (query) => query.where(Order.STATUS,
        //     isEqualTo: OrderHelper.statusToString(OrderStatus.PENDING)),
        sort: (a, b) =>
            (a.beginAt ?? DateTime(0)).compareTo(b.beginAt ?? DateTime(0)),
      );

  @override
  Future<List<Order>> getOrdersByDates(
          {required DateTime start, required DateTime end}) =>
      _service.getCollection(
        path: APIPath.orders(),
        builder: (data, documentId) {
          return Order.fromMap(data, documentId);
        },
        queryBuilder: (query) =>
            query.where(Order.BEGIN_AT, isGreaterThan: start, isLessThan: end),
        sort: (a, b) =>
            (a.beginAt ?? DateTime(0)).compareTo(b.beginAt ?? DateTime(0)),
      );

  @override
  Stream<Order> orderStream({required String orderId}) =>
      _service.documentStream(
        path: APIPath.order(orderId),
        builder: (data, documentId) => Order.fromMap(data, documentId),
      );

  @override
  //TODO: нормально сделать, проверить, выяснить зачем documentId
  Future<Order> getOrder({required String orderId}) => _service.getDocument(
      path: APIPath.order(orderId),
      builder: (data, documentId) => Order.fromMap(data!, documentId));

  @override
  Stream<List<Order>> newOrdersStream() => _service.collectionStream(
        path: APIPath.orders(),
        builder: (data, documentId) => Order.fromMap(data, documentId),
        queryBuilder: (query) => query.where(Order.STATUS,
            isEqualTo: OrderHelper.statusToString(OrderStatus.PENDING)),
        sort: (a, b) =>
            (a.beginAt ?? DateTime(0)).compareTo(b.beginAt ?? DateTime(0)),
      );

  @override
  Future<List<Order>> getExecutingOrders() => _service.getCollection(
        path: APIPath.orders(),
        builder: (data, documentId) {
          return Order.fromMap(data, documentId);
        },
        queryBuilder: (query) => query.where(Order.STATUS,
            isEqualTo: OrderHelper.statusToString(OrderStatus.EXECUTING)),
        sort: (a, b) =>
            (b.beginAt ?? DateTime(0)).compareTo(a.beginAt ?? DateTime(0)),
      );

  @override
  Future<void> updateOrder(
      {required String orderId, required Map<String, dynamic> data}) {
    return _service.updateData(
      path: APIPath.order(orderId),
      data: data,
    );
  }

  // @override
  // Future<List<ServiceNested>> getServiceNested(
  //     String serviceId, String city, serviceNestedType type) async {
  //   List<ServiceNested> attachments = await _service.getCollection(
  //       path: APIPath.servicesNested(serviceId: serviceId, type: type),
  //       builder: (data, documentId) => ServiceNested.fromMap(data, documentId));
  //   for (int i = 0; i < attachments.length; i++) {
  //     attachments[i].price = await getPrice(
  //         serviceId: serviceId,
  //         type: type,
  //         nestedId: attachments[i].id,
  //         city: city);
  //   }
  //   return attachments;
  // }

  /////////////////////////////////////////// Payments

  @override
  Future<List<Payment>> getPayments() async {
    final payments = await _service.getCollection<Payment>(
      path: APIPath.payments(),
      builder: (data, documentId) => Payment.fromMap(data, documentId),
      sort: (a, b) =>
          (a.updatedAt ?? DateTime(0)).compareTo(b.updatedAt ?? DateTime(0)),
    );

    return payments;
  }

  @override
  Future<Payment> getPayment({required String paymentId}) async =>
      _service.getDocument<Payment>(
          path: APIPath.payment(paymentId),
          builder: (data, documentId) => Payment.fromMap(data, documentId));

  /////////////////////////////////////////// Admins

  Future<Admin?> getAdmin({required String userId}) async {
    List<Admin> admins = await _service.getCollection<Admin>(
        path: APIPath.admins(),
        queryBuilder: (query) => query.where(Admin.USER_ID, isEqualTo: userId),
        builder: (data, _) => Admin.fromMap(data));

    return admins.length > 0 ? admins.first : null;
  }

  Future<bool> validateAdmin({required String userId}) async {
    List<Admin> admins = await _service.getCollection<Admin>(
        path: APIPath.admins(),
        queryBuilder: (query) => query.where(Admin.USER_ID, isEqualTo: userId),
        builder: (data, _) => Admin.fromMap(data));

    return admins.length > 0 ? true : false;
  }
}
