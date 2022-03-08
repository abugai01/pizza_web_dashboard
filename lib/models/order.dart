import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';
import 'package:pizza_web_dashboard/logic/order_helper.dart';
import 'package:pizza_web_dashboard/models/address.dart';
import 'package:pizza_web_dashboard/models/basic/price.dart';
import 'package:pizza_web_dashboard/models/constants/order_constants.dart';

//убрал extends AutoId, т.к. мы не создаем заказы и этот функционал в приложении исполнителя не нужен
class Order {
  static const ID = "id";
  static const NUMBER = "number";
  static const USER_ID = "userId";
  static const STATUS = "status";
  static const AMOUNT = "amount";
  static const ADDRESS = "address";
  static const BEGIN_AT = "beginAt";
  static const END_AT = "endAt";
  static const SERVICE = "service";
  static const SUM = "sum";
  static const CREATED_AT = "createdAt";
  static const UPDATED_AT = "updatedAt";
  static const COMMENT = "comment";

  String id;
  int? number;
  String? userId;
  String? executorId;
  String? subscriptionId;
  OrderStatus? status;
  num? amount;
  Address? address;
  Price? sum;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? beginAt;
  DateTime? endAt;
  String? comment;
  bool isNull;

  Order({
    required this.id,
    this.number,
    this.userId,
    this.executorId,
    this.subscriptionId,
    this.status,
    this.amount,
    this.address,
    this.sum,
    this.createdAt,
    this.updatedAt,
    this.beginAt,
    this.endAt,
    this.comment,
    this.isNull = false,
  });

  // Order.create({this.userId, required Service service}) : super(null) {
  //   this.createdAt = DateTime.now();
  //   this.updatedAt = DateTime.now();
  //   this.status = OrderStatus.CREATING;
  //   this.sum = 0;
  //   this.items.add(OrderItem.create(service: service));
  // }

  // void update(
  //     {int index = 0,
  //     Simple? address,
  //     Pet? pet,
  //     num? amount,
  //     String? comment,
  //     ServiceNested? additional,
  //     List<ServiceNested>? additionals,
  //     DateTime? beginAt,
  //     DateTime? endAt}) {
  //   this.address = this.address ?? address;
  //   this.comment = this.comment ?? comment;
  //   this.items[index].update(
  //       pet: pet,
  //       amount: amount,
  //       additional: additional,
  //       additionals: additionals,
  //       beginAt: beginAt,
  //       endAt: endAt);
  //   _recalcSum();
  // }
  //
  // void _recalcSum() {
  //   this.sum = 0;
  //   for (int i = 0; i < this.items.length; i++) {
  //     this.sum += this.items[i].sum;
  //   }
  // }

  static fromMap(Map<String, dynamic>? data, String documentId) {
    // print("we are inside FROM MAP function");
    // print(data);
    // print(documentId);
    // print("data userId: ${data?[USER_ID].toString()}");

    if (data == null) return Order(id: documentId, isNull: true);

    final status = OrderHelper.stringToStatus(data[STATUS]);
    final address = Address.fromMap(
        data[ADDRESS], data[ADDRESS]?[ID]); //TODO: не самый надежный способ!
    //final Schedule schedule = Schedule.fromMap(data[SCHEDULE]);
    final Price sum = Price.fromMap(data[SUM]);

    return Order(
      id: documentId,
      number: data[NUMBER],
      userId: data[USER_ID],
      status: status,
      amount: data[AMOUNT],
      address: address,
      sum: sum,
      createdAt: tryExtractDate(data[CREATED_AT]),
      updatedAt: tryExtractDate(data[UPDATED_AT]),
      beginAt: tryExtractDate(data[BEGIN_AT]),
      endAt: tryExtractDate(data[END_AT]),
      comment: data[COMMENT],
    );
  }

  // @override
  // Map<String, dynamic> toMap() {
  //   //final orderItems = this.items.map((item) => item.toMap()).toList();
  //   final String? status =
  //       OrderHelper.statusToString(this.status); //TODO: null safety
  //
  //   return {
  //     ID: this.id,
  //     NUMBER: this.number,
  //     USER_ID: this.userId,
  //     STATUS: status,
  //     ADDRESS: this.address?.toMap(),
  //     PET: this.pet?.toMap(),
  //     EXECUTOR: this.executor?.toMap(),
  //     SERVICE: this.service?.toMap(),
  //     SUM: this.sum?.toMap(),
  //     CREATED_AT: this.createdAt,
  //     UPDATED_AT: this.updatedAt,
  //     BEGIN_AT: this.beginAt,
  //     COMMENT: this.comment
  //   };
  // }

  //Геттеры
  //OrderStatus get statusEnum => OrderHelper.stringToStatus(status!);
  String get statusTranslated => OrderHelper.statusToTranslatedString(status);
  String? get statusText => OrderHelper.statusToString(status);
  // ServiceType get serviceTypeEnum =>
  //     ServiceHelper.stringToServiceType(serviceId!);
  String get createdAtFormatted =>
      rusDateFormatter(createdAt, fmt: DateFormats.DMMM);
  String get createdAtText => "Создан " + createdAtFormatted;
  String get updatedAtFormatted =>
      rusDateFormatter(updatedAt, fmt: DateFormats.DMMM);
  String get beginAtString => generateDateText(this.beginAt, includeTime: true);
  String get beginAtTimeString => rusDateFormatter(this.beginAt,
      fmt: DateFormats.HHMM); //TODO: что по дате начала???
  int? get durationInMinutes => (this.beginAt == null || this.endAt == null)
      ? null
      : this.endAt!.difference(this.beginAt!).inMinutes;
  String? get durationInMinutesText => (durationInMinutes == null)
      ? null
      : durationInMinutes.toString() + ' ' + 'мин.';

  // String get serviceNameAndDuration =>
  //     "Выгул" + "," + durationText; //TODO: сделать нормально

  // String? get priceText => (price != null)
  //     ? price!.toStringAsFixed(0) + ' ₽'
  //     : null; //TODO: заменить на геттер в модели price
  // String? get executorPriceText =>
  //     (executorPrice != null) ? executorPrice!.toStringAsFixed(0) + ' ₽' : null;
  // String? get executorPriceTextFull =>
  //     (executorPriceText != null) ? "Стоимость: $executorPriceText" : null;

  // String? get serviceTimeString =>
  //     convertTimeDoubleToString(parameters.serviceTime);

  // String? get weekdaysText => generateWeekdaysText(parameters.weekdays);

  // String get dateOrDateRangeText => generateDateOrDateRangeText(
  //     startDate: parameters?.startDate,
  //     endDate: parameters?.endDate,
  //     recurring: parameters?.recurring);

  //TODO: null safety + в будущем хорошо бы очищать адрес от лишних элементов (страна, область)
  String? get addressText => address?.description;
  String? get shortAddressText => address?.shortDescription;
  // String get scheduledAtTimeString =>
  //     rusDateFormatter(parameters.scheduledAt, fmt: DateFormats.HHMM);
  // String get durationText =>
  //     OrderConstants.durationOptionsInfo[parameters.walkDuration] ??
  //     ''; //TODO: для других услуг тоже!
  String get orderNumberText =>
      (number != null) ? "Номер заказа: ${number.toString()}" : '';
  String? get commentText =>
      (comment != null) ? "Комментарий к заказу:\n$comment" : null;

  // int? get dateDiff =>
  //     (parameters.startDate != null && parameters.endDate != null)
  //         ? parameters.endDate.difference(parameters.startDate).inDays
  //         : null; //TODO: проверка на случай null

  //TODO: важно не допустить ситуации, когда (пусть даже теоретически) можно отменить чужой заказ
  bool get canBeCancelled =>
      OrderConstants.cancellable_statuses.contains(this.status) ? true : false;
  bool get canBeTaken =>
      (status == OrderStatus.PENDING && executorId == null) ? true : false;
  bool get canBeAssigned =>
      OrderConstants.assignable_statuses.contains(this.status) ? true : false;
  bool get isActive =>
      OrderConstants.active_statuses.contains(this.status) ? true : false;
  // bool get isExecuting =>
  //     (status == OrderStatus.EXECUTING) ? true : false;
  bool get isActual =>
      OrderConstants.actual_statuses.contains(this.status) ? true : false;
  bool get isFinished =>
      OrderConstants.finished_statuses.contains(this.status) ? true : false;
  bool get isCancelled =>
      OrderConstants.cancelled_statuses.contains(this.status) ? true : false;
  bool get isWaiting =>
      OrderConstants.waiting_statuses.contains(this.status) ? true : false;
}
