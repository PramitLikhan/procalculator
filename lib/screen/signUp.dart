import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

class SignUp extends StatefulWidget {
  static const routeName = 'signUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color primaryLight = Theme.of(context).primaryColorLight;
    Color primary = Theme.of(context).primaryColor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: height * 0.7,
            decoration: BoxDecoration(
//              color: primary,
//              image: DecorationImage(
//                image: AssetImage(
//                  'images/bg5.jpg',
//                ),
//                colorFilter: ColorFilter.mode(primaryLight.withOpacity(0.9), BlendMode.dstOut),
//                fit: BoxFit.fill,
//              ),
                ),
          ),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                colors: [Colors.white, primaryLight],
//                begin: Alignment.topCenter,
//                end: Alignment.bottomCenter,
//              ),

              color: primaryLight,
//          color: Colors.black87,
            ),
          ),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
//              gradient: gradientBackground(context),
              color: primaryLight,
//          color: Colors.black87,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: width * 0.9,
                  child: Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: neuText(
                        text: 'Create an account',
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2,
                        color: primary,
                        depth: 0,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 3,
                    intensity: 5,
                    lightSource: LightSource.topLeft,
                    color: Colors.grey.shade200,
//                    color: primaryLight,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: neumorphicTextField(Colors.white, width, context, 'Username'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: neumorphicTextField(Colors.white, width, context, 'Email'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: neumorphicTextField(Colors.white, width, context, 'Password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: neumorphicTextField(Colors.white, width, context, 'Confirm Password'),
                      ),
//                      SizedBox(
//                        height: height * 0.05,
//                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: buttonBuilder(
                          context,
                          height: height,
                          width: width,
                          bodyColor: Colors.white,
                          text: 'Sign Up',
                          textColor: primary,
//                          onPressed: () => Navigator.pushNamed(context, MainChatPage.routeName,),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Go back',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            textBaseline: TextBaseline.ideographic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  NeumorphicText neuText({
    String text,
    double fontSize,
    FontWeight fontWeight,
    double letterSpacing,
    Color color,
    double depth,
  }) {
    return NeumorphicText(
      text,
      textStyle: NeumorphicTextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
//        fontFamily: 'Nexa',
        letterSpacing: letterSpacing,
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: depth,
        intensity: 10,
        lightSource: LightSource.topLeft,
        color: color,
      ),
    );
  }

  Neumorphic neumorphicTextField(Color primaryLight, double width, BuildContext context, String text) {
    return Neumorphic(
      style: neuStyle(primaryLight, -3),
      child: Container(
        width: width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
//          decoration: textFieldInputDecoration(
//            context,
//            text,
//            Icon(Icons.account_circle),
//          ),
//
          decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Theme.of(context).primaryColor,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(Icons.account_circle)),
        ),
      ),
    );
  }

  NeumorphicStyle neuStyle(Color primaryLight, double depth) {
    return NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: depth,
      intensity: 5,
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
        depth: 1,
        disableDepth: false,
        lightSource: LightSource.top,
        color: bodyColor,
      ),
      curve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: neuText(text: text, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0, color: textColor, depth: 0),
      ),
    );
  }
}
