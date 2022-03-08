import 'package:pizza_web_dashboard/pages/overview/overview.dart';
import 'package:pizza_web_dashboard/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'authentication/authentication.dart';
import 'package:pizza_web_dashboard/pages/orders/orders_page.dart';

//TODO: подумать что с этим делать...
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return AuthenticationPage();
          }
          //return OverviewPage(); //TODO: сделать и вернуть!
          return OrdersPage();
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
