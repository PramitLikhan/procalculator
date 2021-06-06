import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = 'authenticationScreen';
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'login',
          ),
        ),
      ),
    );
  }
}
