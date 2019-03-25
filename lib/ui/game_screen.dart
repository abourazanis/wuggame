import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/widgets/fade_container.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  GameScreenState createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _screenController;
  Animation<Color> fadeScreenAnimation;
  Animation<double> containerGrowAnimation;

  @override
  void initState() {
    super.initState();
    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    fadeScreenAnimation = new ColorTween(
      begin: WugColors.greyBlue,
      end: WugColors.darkBlue,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: Curves.ease,
      ),
    );

    containerGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeIn,
    );

    containerGrowAnimation.addListener(() {
      this.setState(() {});
    });
    containerGrowAnimation.addStatusListener((AnimationStatus status) {});

    _screenController.forward();
  }

  @override
  void dispose() {
    _screenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: WugColors.darkBlue,
        body: new Container(
            width: screenSize.width,
            height: screenSize.height,
            child: new Stack(
                //alignment: buttonSwingAnimation.value,
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Center(
                    child: Text("Hiiii"),
                  ),
                  FadeContainer(
                    fadeScreenAnimation: fadeScreenAnimation,
                    containerGrowAnimation: containerGrowAnimation,
                  ),
                ])));
  }
}
