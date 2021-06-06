import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screen/Calculator/calculator_logic.dart';
import 'neuCalculatorButton.dart';
import 'neumorphicTheme.dart';

class CalculatorScreen extends StatelessWidget {
  static const routeName = 'calculatorScreen';
  final databaseReference = FirebaseDatabase.instance.reference().child('Equations');
  final ScrollController scrollController = ScrollController();

  String equation = '';
  num result = 0;
  var previousId;
  var tempId;
  CalculatorScreen();
  CalculatorScreen.name(String eq, num result, num previousId, num newId) {
    this.equation = eq;
    this.result = result;
    this.previousId = previousId;
    this.tempId = newId;
  }

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context);
    print('check values $equation = $result');

    return WillPopScope(
      onWillPop: () async {
        _onBackPressed(context);
        return true;
      },
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.indigo,
              ),
            ),
            body: Material(
              child: Container(
                decoration: BoxDecoration(
//                  color: Colors.white,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.grey.shade300,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Text(
                                      context.read<Calculator>().eq,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  calculator.value.toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 100,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),

                    ButtonRow(children: [
                      NeuCalculatorButton(
                        text: 'AC',
                        textColor: Colors.red,
                        onPressed: () {
                          calculator.reset();
                        },
                      ),
                      NeuCalculatorButton(
                        text: 'C',
                        textColor: Colors.indigo,
                        onPressed: calculator.removeLast,
                        isPill: true,
                      ),
//                      NeuCalculatorButton(
//                        text: '%',
//                        textColor: Colors.indigo,
//                        onPressed: () {},
//                      ),
                      NeuCalculatorButton(
                        text: '÷',
                        textColor: kOrange,
                        textSize: 45,
                        onPressed: () {
                          scrollController.jumpTo(scrollController.position.maxScrollExtent);
                          calculator.divide();
                        },
                        isChosen: calculator.currentVariable is CalculatorDivide,
                      ),
                    ]),
                    ButtonRow(
                      children: [
                        NeuCalculatorButton(
                          text: '7',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(7),
                        ),
                        NeuCalculatorButton(
                          text: '8',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(8),
                        ),
                        NeuCalculatorButton(
                          text: '9',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(9),
                        ),
                        NeuCalculatorButton(
                          text: 'x',
                          textColor: kOrange,
                          onPressed: () {
                            scrollController.jumpTo(scrollController.position.maxScrollExtent);
                            calculator.multiply();
                          },
                          isChosen: calculator.currentVariable is CalculatorMultiply,
                        ),
                      ],
                    ),
                    ButtonRow(
                      children: [
                        NeuCalculatorButton(
                          text: '4',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(4),
                        ),
                        NeuCalculatorButton(
                          text: '5',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(5),
                        ),
                        NeuCalculatorButton(
                          text: '6',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(6),
                        ),
                        NeuCalculatorButton(
                          text: '-',
                          textColor: kOrange,
                          textSize: 50,
                          onPressed: () {
                            scrollController.jumpTo(scrollController.position.maxScrollExtent);
                            calculator.deduct();
                          },
                          isChosen: calculator.currentVariable is CalculatorDeduct,
                        ),
                      ],
                    ),
                    ButtonRow(
                      children: [
                        NeuCalculatorButton(
                          text: '1',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(1),
                        ),
                        NeuCalculatorButton(
                          text: '2',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(2),
                        ),
                        NeuCalculatorButton(
                          text: '3',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(3),
                        ),
                        NeuCalculatorButton(
                          text: '+',
                          textColor: kOrange,
                          textSize: 45,
                          onPressed: () {
                            scrollController.jumpTo(scrollController.position.maxScrollExtent);
                            calculator.add();
                          },
                          isChosen: calculator.currentVariable is CalculatorAdd,
                        ),
                      ],
                    ),
                    ButtonRow(
                      children: [
                        NeuCalculatorButton(
                          text: '0',
                          textColor: Colors.blue,
                          onPressed: () => calculator.setValue(0),
                          isPill: true,
                        ),
                        NeuCalculatorButton(
                          text: '.',
                          textColor: Colors.blue,
                          onPressed: () {},
                        ),
                        NeuCalculatorButton(
                          text: '=',
                          textColor: Colors.green,
                          textSize: 45,
                          onPressed: () {
                            var user = FirebaseAuth.instance.currentUser;
                            String userId = user.uid;
                            print(userId);
//                            equation = context.read<Calculator>().eq;
                            calculator.showResult();
                            result = context.read<Calculator>().finalResult;

                            equation = calculator.eq;
//                            result = context.read<Calculator>().value;
                            scrollController.jumpTo(scrollController.position.maxScrollExtent);
                            print('inside calculator screen $equation = $result');
                            addEquation(userId);
                          },
                        ),
                      ],
                    ),
//                  SizedBox(
//                    height: MediaQuery.of(context).padding.bottom,
//                  ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    context.read<Calculator>().reset();
    return true;
  }

  void addEquation(String userId) {
    print('I am here to add data to $userId');
    print('$equation = $result');
//    DateTime dt = DateTime.parse(DateFormat('yyyy-MM-dd').add_jm().format(DateTime.now()));
    DateTime dt = DateTime.now();
    final eqRef = FirebaseFirestore.instance.collection('Equations');
    previousId = previousId == null ? 0 : previousId + 1;
    var newId = tempId == null ? 1 : previousId + 1;
    eqRef.add({
      'userId': userId,
      'time': dt,
      'equation': equation,
      'result': result,
      'previousId': previousId,
      'id': newId,
    }).whenComplete(() => print('done'));
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key,
    @required this.children,
  }) : super(key: key);

  final List<NeuCalculatorButton> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children.map((e) => Expanded(child: e)).toList(),
        ),
      ),
    );
  }
}
