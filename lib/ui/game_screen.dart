import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/utils.dart';
import 'package:wug_game/ui/widgets/animated_wave.dart';
import 'package:wug_game/ui/widgets/fade_container.dart';
import 'package:wug_game/ui/widgets/game_animated_background.dart';
import 'package:wug_game/ui/widgets/game_listitem.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:wug_game/ui/widgets/game_topbar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  GameScreenState createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  AnimationController _screenController;
  AnimationController _listItemController;
  AnimationController _listItemPositionController;
  bool animationComplete = false;
  bool answerSelected = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final phrases = ["Krypton", "Asgard", "Azeroth"];

  final pi = 3.14;

  @override
  void initState() {
    super.initState();
    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _listItemController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _listItemPositionController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);

    _screenController.addListener(() {
      if (_screenController.isCompleted) {
        _listItemController.forward();
        this.setState(() {
          animationComplete = true;
        });
      }
    });

    _listItemPositionController.addListener(() {
      if (_listItemPositionController.isCompleted) {
        this.setState(() {
          this.answerSelected = true;
        });
      }
    });

    _screenController.forward();
  }

  @override
  void dispose() {
    _screenController.dispose();
    _listItemController.dispose();
    _listItemPositionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;

    return Scaffold(
        body: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Positioned.fill(child: AnimatedBackground()),
              onBottom(AnimatedWave(
                height: 180,
                speed: 1.0,
              )),
              onBottom(AnimatedWave(
                height: 120,
                speed: 0.9,
                offset: pi,
              )),
              onBottom(AnimatedWave(
                height: 220,
                speed: 1.2,
                offset: pi / 2,
              )),
              onTop(GameTopBar()),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: AnimatedList(
                        key: _listKey,
                        shrinkWrap: true,
                        initialItemCount: phrases.length,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 25.0),
                        itemBuilder: (BuildContext context, int index,
                            Animation animation) {
                          return _buildPhrase(phrases[index], index, width);
                        })),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: answerSelected ? 1.0 : 0.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: FlareActor(
                            "assets/flare/Wrong.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: "Error",
                          ),
                        ),
                        Text(
                          "Krypton",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              FadeContainer(buttonController: _screenController),
            ])));
  }

  void selectPhrase(int index, double width) {
    var phrase = phrases.removeAt(index);
    _listKey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        animation.addStatusListener((status) {
          if (status == AnimationStatus.dismissed) {
            _listItemPositionController.forward();
          }
        });
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
              .animate(animation),
          child: FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            child: _buildPhrase(phrase, index, width),
          ),
        );
      },
      duration: Duration(milliseconds: 500),
    );
  }

  Widget _buildPhrase(phrase, index, width) {
    return GameListItem(
      title: phrase,
      controller: _listItemController,
      positionController: _listItemPositionController,
      onTap: index != null ? () => selectPhrase(index, width) : null,
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );

  onTop(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
      );
}
