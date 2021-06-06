import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procalculator/provider/googleSignIn.dart';
import 'package:procalculator/screen/home.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color primaryLight = Theme.of(context).primaryColorLight;
    Color primary = Theme.of(context).primaryColor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);
            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return Home();
            } else {
              return buildLoginBody(height, width, primary, provider);
            }
          },
        ),
      ),
    );
  }

  Widget buildLoginBody(double height, double width, Color primary, var provider) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
//        color: Color.fromRGBO(234, 67, 53, 1),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(234, 67, 53, 1),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          topText('Welcome!!', 60),
          SizedBox(
            height: 20,
          ),
          topText('lets get started', 30),

          SizedBox(
            height: height * 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: buttonBuilder(
              context,
              height: height,
              width: width,
              bodyColor: Colors.white,
              text: 'Sign In with ',
              textColor: primary,
              onPressed: () {
                provider.login();
              },
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
//          InkWell(
////            onTap: () => Navigator.pushNamed(context, SignUp.routeName,),
//            child: RichText(
//              text: TextSpan(
//                text: 'Don\'t have an account? ',
//                style: TextStyle(
//                  color: Colors.black38,
//                  fontSize: 16,
//                ),
//                children: [
//                  TextSpan(
//                    text: 'Register now',
//                    style: TextStyle(
//                      fontSize: 18,
//                      fontWeight: FontWeight.bold,
//                      color: Theme.of(context).primaryColor,
//                      textBaseline: TextBaseline.ideographic,
//                      decoration: TextDecoration.underline,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//          SizedBox(
//            height: height * 0.2,
//          ),
        ],
      ),
    );
  }

  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  NeumorphicText neuText({String text, double fontSize, double letterSpacing, Color color}) {
    return NeumorphicText(
      text,
      textStyle: NeumorphicTextStyle(
        fontSize: fontSize,
        letterSpacing: letterSpacing,
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: 0,
        intensity: 10,
        lightSource: LightSource.topLeft,
        color: color,
      ),
    );
  }

  Widget topText(String text, double size) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Text(
          text,
          style: GoogleFonts.adventPro(
            fontSize: size,
            color: Colors.white,
            letterSpacing: 5,
          ),
        ),
      ),
    );
  }

  Neumorphic neumorphicTextField(Color primaryLight, double width, BuildContext context, String text, Widget prefixIcon) {
    return Neumorphic(
      style: neuStyle(primaryLight, -3),
      child: Container(
        width: width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
//          decoration: textFieldInputDecoration(context, text, prefixIcon),
            ),
      ),
    );
  }

  NeumorphicStyle neuStyle(Color primaryLight, double depth) {
    return NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: depth,
      intensity: 10,
      lightSource: LightSource.topLeft,
      color: primaryLight,
    );
  }

  Widget buttonBuilder(
    BuildContext context, {
    double height,
    double width,
    Color bodyColor,
    String text,
    textColor,
    onPressed,
  }) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        intensity: 5,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        depth: 2,
        disableDepth: false,
        lightSource: LightSource.topLeft,
        color: bodyColor,
      ),
      curve: Curves.easeInOut,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                FontAwesomeIcons.google,
                size: 40,
                color: Color.fromRGBO(234, 67, 53, 1),
              ),
              RichText(
                text: TextSpan(
                    text: text,
                    style: GoogleFonts.alegreya(
                      fontSize: 25,
                      color: textColor,
                    ),
                    children: [
                      TextSpan(
                          text: 'Google',
                          style: GoogleFonts.sanchez(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(234, 67, 53, 1),
                          ))
                    ]),
              ),
            ],
          )),
    );
  }
}
