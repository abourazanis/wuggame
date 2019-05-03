import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wug_game/ui/utils.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Score 100",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenAwareSize(14.0, context),
                )),
            Text("Level 2",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenAwareSize(20.0, context),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.white,
                  size: 12,
                ),
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.white,
                  size: 12,
                ),
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.white,
                  size: 12,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
