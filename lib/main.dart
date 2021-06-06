import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:procalculator/provider/googleSignIn.dart';
import 'package:procalculator/provider/neumorphicTheme.dart';
import 'package:procalculator/screen/equationList.dart';
import 'package:procalculator/screen/home.dart';
import 'package:procalculator/screen/login.dart';
import 'package:procalculator/screen/splash.dart';
import 'package:provider/provider.dart';

import 'provider/calculator.dart';
import 'screen/Calculator/calculator_logic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Calculator()),
    ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
    ChangeNotifierProvider(create: (_) => CustomNeumorphicTheme()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(44, 78, 74, 1),
        primaryColorLight: Color.fromRGBO(161, 176, 174, 1),
      ),
      home: SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        Login.routeName: (context) => Login(),
        CalculatorScreen.routeName: (context) => CalculatorScreen(),
        Home.routeName: (context) => Home(),
        EquationList.routeName: (context) => EquationList(),
      },
    );
  }
}
