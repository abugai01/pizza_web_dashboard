import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/download/export_csv.dart';
import 'package:pizza_web_dashboard/models/order.dart';
import 'package:pizza_web_dashboard/models/user.dart';
import 'package:pizza_web_dashboard/services/database.dart';

enum Collection {
  orders,
  users,
  executors,
  telegramMessages,
}

class CubitCollectionDownload extends Cubit<DownloadState> {
  final Database database;

  CubitCollectionDownload(this.database) : super(DownloadInitialState());

  List<dynamic>? data;

  Future<void> downloadCollection(Collection collection) async {
    List<dynamic>? data = await getData(collection);

    if (data != null) ExportCsv.convertAndDownload(data);
  }

  Future<List<dynamic>?> getData(Collection collection) async {
    switch (collection) {
      case Collection.orders:
        await getOrders();
        break;
      case Collection.users:
        await getUsers();
        break;
    }
    return data;
  }

  Future<void> getOrders() async {
    //emit(DownloadLoadingState());

    try {
      List<Order> _data = await database.getOrders();
      //emit(DownloadLoadedState(_data));

      data = _data;
    } catch (e) {
      print(e.toString());
      //emit(DownloadErrorState(ErrorMessages.errorOnLoadingFromFirestore));

      data = null;
      return;
    }
  }

  Future<void> getUsers() async {
    //emit(DownloadLoadingState());

    try {
      List<User> _data = await database.getUsers();
      //emit(DownloadLoadedState(_data));

      data = _data;
    } catch (e) {
      print(e.toString());
      //emit(DownloadErrorState(ErrorMessages.errorOnLoadingFromFirestore));

      data = null;
      return;
    }
  }
}
