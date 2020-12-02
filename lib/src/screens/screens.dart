import 'package:flutter/material.dart';
import 'add_item_screen.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class Screens {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const ADD_ITEM = '/home/add_item';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case HOME:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case ADD_ITEM:
        return MaterialPageRoute(
            builder: (context) => AddItemScreen(
                  category: settings.arguments,
                ));
    }
    return null;
  }
}
