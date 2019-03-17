import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as m;
import 'package:wug_game/ui/colors.dart';

class MenuButtonAnimation extends StatelessWidget {
  MenuButtonAnimation({
    Key key,
    @required this.buttonController,
    @required this.screenWidth,
    @required this.screenHeight,
    @required this.onPressed,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    this.iconColor = Colors.white,
  })  : buttonRotateAnimation = Tween<double>(
          begin: 0.0,
          end: 180.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.0,
              0.19,
              curve: Curves.decelerate,
            ),
          ),
        ),
        buttomZoomOut = Tween(
          begin: 160.0,
          end: 1000.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.19,
              0.99,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  final String title;
  final String subtitle;
  final Color iconColor;
  final IconData icon;
  final GestureTapCallback onPressed;

  final double screenWidth;
  final double screenHeight;

  final AnimationController buttonController;
  final Animation buttonRotateAnimation;
  final Animation buttomZoomOut;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Transform.rotate(
        angle: m.radians(buttonRotateAnimation.value),
        child: _buildButton(buttomZoomOut.value, buttomZoomOut.value));
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        print("animation finished");
      }
    });
    return new AnimatedBuilder(
      builder: _buildAnimation,
      child: _buildButton(160, 160),
      animation: buttonController,
    );
  }

  Widget _buildButton(double width, double height) {
    return RawMaterialButton(
      onPressed: this.onPressed,
      fillColor: WugColors.greyBlue,
      splashColor: WugColors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        width: width,
        height: height,
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
    );
  }
}
