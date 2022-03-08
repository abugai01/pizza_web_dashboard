import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/models/user.dart';
import 'package:pizza_web_dashboard/services/database.dart';

class CubitUsers extends Cubit<UserState> {
  final Database database;

  late List<User> users;

  CubitUsers(this.database) : super(UserInitialState()) {
    getUsers();
  }

  void getUsers() async {
    emit(UserLoadingState());

    try {
      users = await database.getUsers();
      emit(UsersLoadedState(users));
    } catch (e) {
      print(e.toString());
      emit(UserErrorState(ErrorMessages.errorOnLoadingFromFirestore));
      return;
    }
  }
}
