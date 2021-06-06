import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procalculator/provider/googleSignIn.dart';
import 'package:procalculator/screen/equationList.dart';
import 'package:provider/provider.dart';

import 'file:///F:/doctorbaari_app_main-master/procalculator/procalculator/lib/provider/calculator.dart';

class Home extends StatelessWidget {
  static const routeName = 'home';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final eqRef = FirebaseFirestore.instance.collection('Equations');
    var user = FirebaseAuth.instance.currentUser;
    String userId = user.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.indigo),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: Row(
                  children: [
                    Text(
                      'Log out',
                      style: GoogleFonts.alatsi(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.logout,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey.shade300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CalculatorScreen.routeName);
                    },
                    child: neumorphicButton(
                      height: height,
                      width: width,
                      text: 'Go to Calculator',
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: eqRef.where('id', isEqualTo: userId).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, EquationList.routeName);
                          },
                          child: neumorphicButton(
                            height: height,
                            width: width,
                            text: 'See Calculation History',
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class neumorphicButton extends StatelessWidget {
  const neumorphicButton({
    Key key,
    @required this.height,
    @required this.width,
    this.text,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        color: Colors.white,
      ),
      child: Container(
        height: height * 0.3,
        width: width * 0.9,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.sanchez(
              fontSize: 40,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
