import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:procalculator/screen/login.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  Animation animation1, animation2;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOutCirc));

    animation2 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    Timer(Duration(seconds: 5), () => goTo());
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Scaffold(
//      backgroundColor: Colors.blue,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Transform.scale(
              scale: animation1.value,
              child: Opacity(
                opacity: animation2.value,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.calculator,
                        ),
                      ),
                      Text(
                        'Pro Calculator',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void goTo() async {
    Navigator.pushReplacementNamed(context, Login.routeName);
  }
}
