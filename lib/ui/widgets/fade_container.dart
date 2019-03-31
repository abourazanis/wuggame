import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';

class FadeContainer extends StatelessWidget {

  FadeContainer({
    Key key,
    @required this.buttonController}):

    fadeScreenAnimation =ColorTween(
      begin: WugColors.greyBlue,
      end: WugColors.darkBlue,
    ).animate(
      new CurvedAnimation(
        parent: buttonController,
        curve: Curves.ease,
      ),
    ),
    containerGrowAnimation = CurvedAnimation(
      parent: buttonController,
      curve: Curves.easeIn,
    ),
  super(key: key);

  final AnimationController buttonController;
  final Animation<Color> fadeScreenAnimation;
  final Animation<double> containerGrowAnimation;

  Widget _buildAnimation(BuildContext context, Widget child) {
      Size screenSize = MediaQuery.of(context).size;

      return Hero(
        tag: "fade",
        child: Container(
          width: containerGrowAnimation.value < 1 ? screenSize.width : 0.0,
          height: containerGrowAnimation.value < 1 ? screenSize.height : 0.0,
          decoration: BoxDecoration(
            color: fadeScreenAnimation.value,
          ),
        ));
    }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
