import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/routing/router.dart';
import 'package:pizza_web_dashboard/services/auth.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

//todo: make sure only admins have access!
//todo: english everywhere!
//todo: reuse individual widgets as much as possible!!!
//todo: protect database with security rules!! as keys are available in the config
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: Provider<FirestoreDatabase>(
        create: (_) => FirestoreDatabase(),
        child: MaterialApp(
          onGenerateRoute: generateRoute,
          //initialRoute: '/',
          debugShowCheckedModeBanner: false,
          title: 'Pizza Web Dashboard',
          theme: ThemeData(
            scaffoldBackgroundColor: light,
            textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            primarySwatch: Colors.blue,
          ),
          //home: HomePage(),
        ),
      ),
    );
  }
}
