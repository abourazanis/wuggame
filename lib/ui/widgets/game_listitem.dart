import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/utils.dart';

class GameListItem extends StatelessWidget {
  final String title;
  final AnimationController controller;
  final AnimationController positionController;
  final Animation borderAnimation;
  final Animation positionAnimation;
  final GestureTapCallback onTap;

  GameListItem(
      {Key key,
      @required this.title,
      @required this.controller,
      @required this.positionController,
      @required this.onTap})
      : borderAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.99,
              // curve: Curves.easeInOut,
            ),
          ),
        ),
        positionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: positionController,
            curve: Interval(
              0.4,
              1.0,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: positionController,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.translationValues(
              positionAnimation.value * width, 0.0, 0.0),
          child: InkWell(
            splashColor: WugColors.lightBlue,
            onTap: this.onTap,
            child: AnimatedOpacity(
              opacity: positionAnimation.value > 0.0 ? 0 : 1,
              duration: Duration(milliseconds: 600),
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      screenAwareSize(20.0, context),
                      screenAwareSize(15.0, context),
                      screenAwareSize(20.0, context),
                      screenAwareSize(15.0, context)),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: WugColors.lightBlue
                              .withOpacity(borderAnimation.value),
                          width: 3),
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
                  )),
            ),
          ),
        );
      },
    );
  }
}
