import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procalculator/provider/calculator.dart';
import 'package:provider/provider.dart';

import 'Calculator/calculator_logic.dart';

class EquationList extends StatefulWidget {
  static const routeName = 'Calculations';
  @override
  _EquationListState createState() => _EquationListState();
}

class _EquationListState extends State<EquationList> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final eqRef = FirebaseFirestore.instance.collection('Equations').orderBy('time');
    String userId = user.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.indigo,
        ),
        title: Text(
          'Calculation History',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Container(
            child: StreamBuilder(
              stream: eqRef.where('userId', isEqualTo: userId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data.docs[snapshot.data.docs.length - 1 - index].data());
                        return InkWell(
                          onTap: () {
                            context.read<Calculator>().setActions(snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['equation']);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalculatorScreen.name(
                                  snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['equation'],
                                  snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['result'],
                                  snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['previousId'],
                                  snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['id'],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
//                                leading: Text(
//                                  '${snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['id']}',
//                                  style: TextStyle(
//                                    fontSize: 20,
//                                  ),
//                                ),
                                title: Text(
                                  '${snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['equation']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text(
                                  '${snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['result']}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: Text(
                                  '${DateFormat('yyyy-MM-dd').add_jm().format(snapshot.data.docs[snapshot.data.docs.length - 1 - index].data()['time'].toDate()).toString()}',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }
}
