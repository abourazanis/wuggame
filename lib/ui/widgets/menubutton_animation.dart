import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as m;
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/game_screen.dart';
import 'package:wug_game/ui/widgets/fadeout_route.dart';
import 'package:simple_animations/simple_animations.dart';

class MenuButtonAnimation extends StatelessWidget {
  MenuButtonAnimation({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    this.iconColor = Colors.white,
  })  : tween = MultiTrackTween([
          Track("rotate").add(
              Duration(milliseconds: 90),
              Tween<double>(
                begin: 0.0,
                end: 180.0,
              ),
              curve: Curves.decelerate),
          Track("zoomOut")
              .add(
                  Duration(milliseconds: 70),
                  ConstantTween(
                    1.0,
                  ),
                  curve: Curves.easeOutExpo)
              .add(
                  Duration(milliseconds: 200),
                  Tween(
                    begin: 1.0,
                    end: 10.0,
                  ),
                  curve: Curves.easeOutExpo),
          Track("position")
              .add(Duration(milliseconds: 90), ConstantTween(0.0))
              .add(Duration(milliseconds: 90),
                  Tween<double>(begin: 0, end: 0.25),
                  curve: Curves.decelerate),
          Track("opacity")
              .add(Duration(milliseconds: 10), ConstantTween(1.0))
              .add(Duration(milliseconds: 90),
                  Tween<double>(begin: 1.0, end: 0.0),
                  curve: Curves.ease),
        ]),
        super(key: key);

  final String title;
  final String subtitle;
  final Color iconColor;
  final IconData icon;

  final MultiTrackTween tween;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return ControlledAnimation(
        duration: Duration(milliseconds: 2500),
        tween: tween,
        child: _buildButton(160, 160),
        animationControllerStatusListener: (status) {
          if (status == AnimationStatus.completed) {
            Navigator.pushReplacement(
                context, FadeOutRoute(widget: GameScreen()));
          }
        },
        builderWithChild: (context, child, animation) => Transform(
            alignment: FractionalOffset.center,
            transform:
                Matrix4.translationValues(animation["position"] * width, 0, 0)
                  ..rotateZ(m.radians(animation["rotate"]))
                  ..scale(animation["zoomOut"]),
            child: _buildButton(160, 160, opacity: animation["opacity"])));
  }

  Widget _buildButton(double width, double height, {double opacity: 1.0}) {
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
                    color: Colors.white.withOpacity(opacity),
                    fontWeight: FontWeight.normal),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5.0, 0, 10.0),
                height: 2,
                width: 25,
                color: this.iconColor.withOpacity(opacity),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(opacity),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Icon(
                this.icon,
                color: this.iconColor.withOpacity(opacity),
                size: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
