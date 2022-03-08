import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/cubits/order/cubit_orders.dart';
import 'package:pizza_web_dashboard/models/basic/payment.dart';
import 'package:pizza_web_dashboard/models/internal/executor_stat.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/models/review.dart';
import 'package:pizza_web_dashboard/models/user.dart' as UserModel;

//todo: split

abstract class AuthState extends Equatable {}

class UnauthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  AuthenticatedState(this.auth);

  final FirebaseAuth auth;

  @override
  List<Object> get props => [auth];
}

class AuthenticationErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class OrderState extends Equatable {}

class OrderInitialState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadingState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadedState extends OrderState {
  OrderLoadedState(this.order);

  final Order order;

  @override
  List<Object> get props => [order];
}

class OrdersLoadedState extends OrderState {
  final List<Order> orders;
  final FilterTypeStatus filterStatus;

  OrdersLoadedState(this.orders, {this.filterStatus = FilterTypeStatus.All});

  @override
  List<Object> get props => [orders, filterStatus];
}

class OrderErrorState extends OrderState {
  final String error;

  OrderErrorState(this.error);

  @override
  List<Object> get props => [];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final UserModel.User user;

  UserLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class UsersLoadedState extends UserState {
  UsersLoadedState(this.users);

  final List<UserModel.User> users;

  @override
  List<Object> get props => [users];
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);

  @override
  List<Object> get props => [error];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class ReviewState extends Equatable {}

class ReviewInitialState extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoadingState extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewsLoadedState extends ReviewState {
  ReviewsLoadedState(this.reviews);

  final List<Review> reviews;

  @override
  List<Object> get props => [reviews];
}

class ReviewErrorState extends ReviewState {
  final String error;

  ReviewErrorState(this.error);

  @override
  List<Object> get props => [error];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class StatsState extends Equatable {}

// class StatsEmptyState extends StatsState {
//   @override
//   List<Object> get props => [];
// }
//
// class StatsPresentState extends StatsState {
//   final Map<String, num> statsMap;
//
//   StatsPresentState(this.statsMap);
//
//   @override
//   List<Object> get props => [statsMap];
// }

class StatsGenericState extends StatsState {
  final Map<String, num> statsMap;

  StatsGenericState(this.statsMap);

  @override
  List<Object> get props => [statsMap];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class PaymentState extends Equatable {}

class PaymentInitialState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentLoadingState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentsLoadedState extends PaymentState {
  final List<Payment> payments;

  PaymentsLoadedState(this.payments);

  @override
  List<Object> get props => [payments];
}

class PaymentErrorState extends PaymentState {
  final String error;

  PaymentErrorState(this.error);

  @override
  List<Object> get props => [error];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class ExecutorStatsState extends Equatable {}

class ExecutorStatsInitialState extends ExecutorStatsState {
  @override
  List<Object> get props => [];
}

class ExecutorStatsLoadingState extends ExecutorStatsState {
  @override
  List<Object> get props => [];
}

class ExecutorStatsLoadedState extends ExecutorStatsState {
  final List<ExecutorStat> stats;

  ExecutorStatsLoadedState(this.stats);

  @override
  List<Object> get props => [stats];
}

class ExecutorStatsErrorState extends ExecutorStatsState {
  final String error;

  ExecutorStatsErrorState(this.error);

  @override
  List<Object> get props => [error];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class DownloadState extends Equatable {}

class DownloadInitialState extends DownloadState {
  @override
  List<Object> get props => [];
}

class DownloadLoadingState extends DownloadState {
  @override
  List<Object> get props => [];
}

class DownloadLoadedState extends DownloadState {
  final List<dynamic> data;

  DownloadLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class DownloadErrorState extends DownloadState {
  final String error;

  DownloadErrorState(this.error);

  @override
  List<Object> get props => [error];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

abstract class WeekSelectorState extends Equatable {}

class WeekSelectorGenericState extends WeekSelectorState {
  final int weekCounter;
  final String text;
  final DateTimeRange weekRange;
  // final DateTime weekStart;
  // final DateTime weekEnd;
  final bool isBeforeButtonEnabled;
  final bool isNextButtonEnabled;

  WeekSelectorGenericState({
    required this.weekCounter,
    required this.text,
    required this.weekRange,
    // required this.weekStart,
    // required this.weekEnd,
    this.isBeforeButtonEnabled = true,
    this.isNextButtonEnabled = true,
  });

  @override
  List<Object> get props => [weekCounter];
}
