import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/utils.dart';
import 'package:wug_game/ui/widgets/fade_container.dart';
import 'package:wug_game/ui/widgets/game_listitem.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  GameScreenState createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  AnimationController _screenController;
  Animation<Color> fadeScreenAnimation;
  Animation<double> containerGrowAnimation;
  AnimationController _listItemController;
  bool animationComplete = false;

  @override
  void initState() {
    super.initState();
    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _listItemController = new AnimationController(
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

    _screenController.addListener(() {
      if (_screenController.isCompleted) {
        _listItemController.forward();
        this.setState(() {
          animationComplete = true;
        });
      }
    });

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
        body: Container(
            width: screenSize.width,
            height: screenSize.height,
            padding: EdgeInsets.only(
              left: screenAwareSize(25.0, context),
              right: screenAwareSize(25.0, context),
            ),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.only(
                    top: animationComplete
                        ? 0.0
                        : screenAwareSize(150.0, context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GameListItem(
                      title: "Krypton",
                      controller: _listItemController,
                    ),
                    SizedBox(height: screenAwareSize(15.0, context)),
                    GameListItem(
                        title: "Asgard", controller: _listItemController),
                    SizedBox(height: screenAwareSize(15.0, context)),
                    GameListItem(
                      title: "Azeroth",
                      controller: _listItemController,
                    )
                  ],
                ),
              ),
              FadeContainer(
                fadeScreenAnimation: fadeScreenAnimation,
                containerGrowAnimation: containerGrowAnimation,
              ),
            ])));
  }
}
