import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/utils.dart';
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
        duration: new Duration(milliseconds: 2500), vsync: this);
  }

  @override
  void dispose() {
    _menuButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _menuButtonController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WugColors.darkBlue,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MainAppBar("Wug Game"),
                SizedBox(height: screenAwareSize(20, context)),
                Icon(
                  FontAwesomeIcons.question,
                  color: WugColors.green,
                  size: screenAwareSize(120, context),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                  top: animationStatus ? 0.0 : screenAwareSize(80, context)),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 20.0,
                runSpacing: 20.0,
                children: <Widget>[
                  animationStatus
                      ? MenuButtonAnimation(
                          buttonController: this._menuButtonController.view,
                          title: "Play",
                          subtitle: "NEW GAME",
                          icon: FontAwesomeIcons.gamepad,
                          iconColor: WugColors.orange,
                        )
                      : MainMenuButton(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
