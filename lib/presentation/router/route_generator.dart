import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/presentation/screens/home_screen.dart';
import 'package:todo_list/presentation/screens/login_screen.dart';

class RouteGenerator{
  static Route? generateRoute(RouteSettings settings){

    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }

  }
}