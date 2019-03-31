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
  AnimationController _listItemController;
  AnimationController _listItemPositionController;
  bool animationComplete = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final phrases = ["Krypton", "Asgard", "Azeroth"];

  @override
  void initState() {
    super.initState();
    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _listItemController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _listItemPositionController = new AnimationController(
        duration: new Duration(milliseconds: 600), vsync: this);

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
    _listItemController.dispose();
    _listItemPositionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;

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
                  child: AnimatedList(
                      key: _listKey,
                      initialItemCount: phrases.length,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      itemBuilder: (BuildContext context, int index,
                          Animation animation) {
                        return _buildPhrase(phrases[index], index, width);
                      })),
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
      duration: Duration(milliseconds: 600),
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
}
