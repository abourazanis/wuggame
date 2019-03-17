import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;

  MainAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
        padding: new EdgeInsets.only(top: statusBarHeight),
        height: statusBarHeight + barHeight,
        child: new Center(child: new Text(title)),
        decoration: new BoxDecoration(color: WugColors.darkBlue));
  }
}
