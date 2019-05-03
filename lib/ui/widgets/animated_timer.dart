import 'package:flutter/material.dart';
import 'package:wug_game/ui/colors.dart';
import 'package:wug_game/ui/utils.dart';

class AnimatedTimer extends StatefulWidget {
  AnimatedTimer({Key key}) : super(key: key);

  _AnimatedTimerState createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation get colorAnimation {
    return ColorTween(
      begin: WugColors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.99,
          // curve: Curves.easeInOut,
        ),
      ),
    );
  }

  String get timerString {
    Duration duration = animationController.duration -
        animationController.duration * animationController.value;
    return '${(duration.inSeconds % 60).toString()}';
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: FractionalOffset.center,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (BuildContext context, Widget child) {
                        return CustomPaint(
                            painter: TimerPainter(
                          animation: animationController,
                          backgroundColor: Colors.white,
                          color: colorAnimation.value,
                        ));
                      },
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.center,
                    child: Center(
                        child: AnimatedBuilder(
                            animation: animationController,
                            builder: (_, Widget child) {
                              return Text(timerString,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenAwareSize(60.0, context),
                                  ));
                            })),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  final pi = 3.14;

  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
