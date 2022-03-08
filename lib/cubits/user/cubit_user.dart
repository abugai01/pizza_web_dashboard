import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/constants/error_messages.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/models/address.dart';
import 'package:pizza_web_dashboard/models/user.dart' as UserModel;
import 'package:pizza_web_dashboard/services/database.dart';

class CubitUser extends Cubit<UserState> {
  final Database database;
  //User _user;
  final String userId;

  CubitUser(this.database, {required this.userId}) : super(UserInitialState()) {
    //emit(UserLoadedState(_user));
    loadUser();
    getUserInfo();
  }

  List<Address>? addresses;

  void getUserInfo() async {
    try {
      addresses = await database.getUserAddresses(userId: userId);
    } catch (e) {
      print(e.toString());
      //emit(UserErrorState()); //TODO: этот кусок не должен валить все!
      return;
    }
    //UserLoadedState(_user); //TODO: подумать и сделать нормально
  }

  void loadUser() async {
    emit(UserLoadingState());

    try {
      UserModel.User _user = await database.getUser(userId: userId);
      _user.isNull == true
          ? emit(UserErrorState(ErrorMessages.messageNoDocumentId))
          : emit(UserLoadedState(_user));
    } catch (e) {
      print(e.toString());
      emit(UserErrorState(ErrorMessages.errorOnLoadingFromFirestore));
      return;
    }
  }
}
