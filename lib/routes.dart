import 'package:flutter/material.dart';
import 'package:wug_game/ui/game_screen.dart';
import 'package:wug_game/ui/main_screen.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    "/": (BuildContext context) => new MainScreen(),
    "/game": (BuildContext context) => new GameScreen()
  };
}
