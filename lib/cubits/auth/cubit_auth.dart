import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/services/auth.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class CubitAuth extends Cubit<AuthState> {
  final Database database;
  final AuthBase auth;

  CubitAuth({required this.database, required this.auth})
      : super(AuthenticatingState()) {
    //emit(AuthenticatedState(auth));
    _initialize();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  //TextEditingController name = TextEditingController();
  //TextEditingController phone = TextEditingController();

  static const LOGGED_IN = "loggedIn";
  static const ID = "id";

  Status _status = Status.Uninitialized;

  Future<bool> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _status = Status.Authenticating;

      User? user = await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());

      if (user != null) {
        bool isAdmin = await database.validateAdmin(userId: user.uid);

        if (isAdmin == true) {
          await prefs.setString(ID, user.uid);
          await prefs.setBool(LOGGED_IN, true);
          return true;
        }
      }
      return false;
    } catch (e) {
      _status = Status.Unauthenticated;
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    auth.signOut();
    _status = Status.Unauthenticated;
    //await prefs.setString(ID, null);
    await prefs.remove(ID);
    await prefs.setBool(LOGGED_IN, false);
    return Future.delayed(Duration.zero);
  }

  void clearControllers() {
    email.text = "";
    password.text = "";
    //name.text = "";
    //phone.text = "";
  }

  _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool(LOGGED_IN) ?? false;
    if (!loggedIn) {
      _status = Status.Unauthenticated;
    } else {
      /*
      await auth.currentUser().then((currentUser) async{
        _user = currentUser;
        _status = Status.Authenticated;
      });
      */
      _status = Status.Authenticated;
    }
  }
}
