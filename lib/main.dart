import 'package:flutter/material.dart';
import 'package:wug_game/routes.dart';
import 'package:wug_game/ui/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wug Game',
        theme: wugTheme,
        initialRoute: '/',
        routes: Routes().routes);
  }
}
