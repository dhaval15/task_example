import 'package:flutter/material.dart';
import 'package:task/src/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.white,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black.withOpacity(0.6),
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Screens.SPLASH,
        onGenerateRoute: Screens.onGenerateRoute,
      ),
    );
  }
}
