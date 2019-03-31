import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as m;
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/game_screen.dart';
import 'package:wug_game/ui/widgets/fadeout_route.dart';

class MenuButtonAnimation extends StatelessWidget {
  MenuButtonAnimation({
    Key key,
    @required this.buttonController,
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
              0.15,
              curve: Curves.decelerate,
            ),
          ),
        ),
        buttomZoomOut = Tween(
          begin: 1.0,
          end: 10.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.15,
              0.99,
              curve: Curves.easeOutExpo,
            ),
          ),
        ),
        moveAnimation = Tween<double>(begin: 0, end: 0.25).animate(
            CurvedAnimation(
                parent: buttonController,
                curve: Interval(0.10, 0.20, curve: Curves.decelerate))),
        opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: buttonController,
                curve: Interval(0.15, 0.20, curve: Curves.ease))),
        super(key: key);

  final String title;
  final String subtitle;
  final Color iconColor;
  final IconData icon;

  final AnimationController buttonController;
  final Animation buttonRotateAnimation;
  final Animation buttomZoomOut;
  final Animation opacityAnimation;
  final Animation moveAnimation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    final double width = MediaQuery.of(context).size.width;

    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.translationValues(moveAnimation.value * width, 0, 0)
          ..rotateZ(m.radians(buttonRotateAnimation.value))
          ..scale(buttomZoomOut.value),
        child: _buildButton(160, 160));
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        Navigator.pushReplacement(context, FadeOutRoute(widget: GameScreen()));
      }
    });
    return AnimatedBuilder(
      builder: _buildAnimation,
      child: _buildButton(160, 160),
      animation: buttonController,
    );
  }

  Widget _buildButton(double width, double height) {
    return RawMaterialButton(
      fillColor: WugColors.greyBlue,
      splashColor: WugColors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {},
      child: Container(
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
                    color: Colors.white.withOpacity(opacityAnimation.value),
                    fontWeight: FontWeight.normal),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5.0, 0, 10.0),
                height: 2,
                width: 25,
                color: this.iconColor.withOpacity(opacityAnimation.value),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(opacityAnimation.value),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Icon(
                this.icon,
                color: this.iconColor.withOpacity(opacityAnimation.value),
                size: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
