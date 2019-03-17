import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';

class MainMenuButton extends StatelessWidget {
  MainMenuButton({
    @required this.onPressed,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    this.visible = true,
    this.iconColor = Colors.white,
  });

  final GestureTapCallback onPressed;
  final String title;
  final String subtitle;
  final Color iconColor;
  final IconData icon;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: this.visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: RawMaterialButton(
        onPressed: this.onPressed,
        fillColor: WugColors.greyBlue,
        splashColor: WugColors.lightBlue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          width: 160,
          height: 160,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5.0, 0, 10.0),
                  height: 2,
                  width: 25,
                  color: this.iconColor,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Icon(
                  this.icon,
                  color: this.iconColor,
                  size: 45,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
