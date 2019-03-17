import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/widgets/main_appbar.dart';
import 'package:wug_game/ui/widgets/main_menubutton.dart';
import 'package:wug_game/ui/widgets/menubutton_animation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  MainScreenState createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _menuButtonController;
  var animationStatus = false;

  @override
  void initState() {
    super.initState();
    _menuButtonController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);
  }

  @override
  void dispose() {
    _menuButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _menuButtonController.forward().orCancel;
//      await _menuButtonController.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WugColors.darkBlue,
      body: Stack(
        children: <Widget>[
          AnimatedOpacity(
            opacity: this.animationStatus ? 0.0 : 1.0,
            duration: Duration(milliseconds: 500),
            child: MainAppBar("Wug Game"),
          ),
          _buildMenu(context),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          AnimatedOpacity(
            opacity: this.animationStatus ? 0.0 : 1.0,
            duration: Duration(milliseconds: 500),
            child: Icon(
              FontAwesomeIcons.question,
              color: WugColors.green,
              size: 120,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MenuButtonAnimation(
                buttonController: this._menuButtonController.view,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                onPressed: () {
                  setState(() {
                    animationStatus = true;
                  });
                  _playAnimation();
                },
                title: "Play",
                subtitle: "NEW GAME",
                icon: FontAwesomeIcons.gamepad,
                iconColor: WugColors.orange,
              ),
              MainMenuButton(
                onPressed: () {},
                title: "Settings",
                subtitle: "OPTIONS",
                icon: FontAwesomeIcons.cog,
                iconColor: WugColors.lightBlue,
                visible: !animationStatus,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MainMenuButton(
                onPressed: () {},
                title: "About",
                subtitle: "INFORMATION",
                icon: FontAwesomeIcons.infoCircle,
                iconColor: WugColors.cyan,
                visible: !animationStatus,
              ),
              MainMenuButton(
                onPressed: () {},
                title: "Quit",
                subtitle: "EXIT",
                icon: FontAwesomeIcons.signOutAlt,
                iconColor: WugColors.lila,
                visible: !animationStatus,
              ),
            ],
          )
        ],
      ),
    );
  }
}
