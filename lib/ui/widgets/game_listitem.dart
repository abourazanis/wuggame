import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/utils.dart';

class GameListItem extends StatelessWidget {
  final String title;
  final AnimationController controller;
  final Animation borderWidthAnimation;

  GameListItem({Key key, @required this.title, @required this.controller})
      : borderWidthAnimation = Tween<double>(
          begin: 0.0,
          end: 2.5,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.99,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            screenAwareSize(20.0, context),
            screenAwareSize(15.0, context),
            screenAwareSize(20.0, context),
            screenAwareSize(15.0, context)),
        decoration: BoxDecoration(
            color: WugColors.darkBlue,
            border: Border.all(
                color: WugColors.lightBlue, width: borderWidthAnimation.value),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenAwareSize(20.0, context),
                )),
            Icon(
              FontAwesomeIcons.chevronRight,
              color: Colors.white,
              size: 20,
            )
          ],
        ));
  }
}
