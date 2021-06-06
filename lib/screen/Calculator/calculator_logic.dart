import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends ChangeNotifier {
  num _value = 0;
  List<CalculatorVariable> _actions = [CalculatorNumber('0')];
  String eq = '';
  num finalResult = 0;

  num get value => _value;
  CalculatorVariable get currentVariable => _actions.last;

  void add() {
    takeAction(
      CalculatorAdd(),
      when: _actions.last is! CalculatorAdd,
    );
  }

  void deduct() {
    takeAction(
      CalculatorDeduct(),
      when: _actions.last is! CalculatorDeduct,
    );
  }

  void multiply() {
    takeAction(
      CalculatorMultiply(),
      when: _actions.last is! CalculatorMultiply,
    );
  }

  void divide() {
    takeAction(
      CalculatorDivide(),
      when: _actions.last is! CalculatorDivide,
    );
  }

  void removeLast() {
    _actions = [CalculatorNumber('0')];
    if (value == 0) {
      if (eq != '') {
        eq = eq.substring(0, eq.length - 1);
        print('equation $eq');
        setActions(eq);
      } else {
        eq = '';
        setActions(eq);
        print('equation $eq');
      }
      final List<String> mathVariables = [];
      _actions.forEach((action) => mathVariables.add(action.value));

      final variablesLength = mathVariables.length;

      if (variablesLength.isEven) mathVariables.removeLast();

      this.eq = mathVariables.join(' ');
      _actions.removeLast();
      _value = 0;
    } else {
      var temp2 = _value.toString(); //6 => '6'

      temp2 = temp2.substring(0, temp2.length - 1); //'667' => '66'
      if (temp2.length > 0) {
        print('ami first condition e dhuksi');
        _value = int.parse(temp2);
      } else {
        print('ami second condition e dhuksi');
        _value = 0;
      }
    }
//    _value = 0;
    notifyListeners();
  }

  void takeAction(
    CalculatorVariable action, {
    @required bool when,
  }) {
    if (when) {
      if (_actions.last is MathOperator) {
        _actions.removeLast();
      } else {
        _value = parseCalculatorActions(_actions);
        _value = 0;
      }
      _actions.add(action);
    }
    notifyListeners();
  }

  void reset() {
    _actions = [CalculatorNumber('0')];
    _value = 0;
    eq = '';
    notifyListeners();
  }

  void showResult() {
    _value = parseCalculatorActions(_actions);
    notifyListeners();
  }

  void setValue(num number) {
    if (_actions.last is! CalculatorNumber) _value = 0;

    final stringifyedValue = _value.toString();
    if (_value == 0) {
      _value = number;
    } else {
      _value = int.parse(stringifyedValue + number.toString());
    }

    notifyListeners();

    final lastAction = _actions.last;
    if (lastAction is CalculatorNumber) _actions.removeLast();

    _actions.add(CalculatorNumber(_value.toString()));
  }

  void setActions(String eq) {
    var temp = eq.split(' ');
    _actions = [CalculatorNumber('0')];
    print('temp $temp');
    temp.forEach((element) {
      print('element $element');
      if (element == '+') {
        takeAction(CalculatorAdd(), when: true);
      } else if (element == '-') {
        takeAction(CalculatorDeduct(), when: true);
      } else if (element == '*') {
        takeAction(CalculatorMultiply(), when: true);
      } else if (element == '÷' || element == '/') {
        takeAction(CalculatorDivide(), when: true);
      } else if (element is! CalculatorNumber && temp.indexOf(element) != temp.length - 1) {
        _value = 0;
        final stringifyedValue = _value.toString();
        if (_value == 0) {
          _value = int.parse(element);
        } else {
          _value = int.parse(stringifyedValue + element);
        }
        final lastAction = _actions.last;
        if (lastAction is CalculatorNumber) _actions.removeLast();
        _actions.add(CalculatorNumber(element));
      } else if (temp.indexOf(element) == temp.length - 1) {
        _value = 0;

        print('temp er value ${temp[temp.length - 1]}');
        _actions.add(CalculatorNumber(element));
        final List<String> mathVariables = [];
        _actions.forEach((action) => mathVariables.add(action.value));

        final variablesLength = mathVariables.length;

        if (variablesLength.isEven) mathVariables.removeLast();

        this.eq = mathVariables.join(' ');
      }
    });
  }

  num parseCalculatorActions(List<CalculatorVariable> actions) {
    final List<String> mathVariables = [];

    actions.forEach((action) => mathVariables.add(action.value));

    final variablesLength = mathVariables.length;

    if (variablesLength.isEven) mathVariables.removeLast();

    final equation = mathVariables.join(' ');

    final num result = Parser().parse(equation).evaluate(
          EvaluationType.REAL,
          ContextModel(),
        );

    print('$equation = $result');
    eq = equation;

    final prettierResult = isInteger(result) ? result.round() : result;
    finalResult = prettierResult;

    return prettierResult;
  }
}

abstract class CalculatorVariable {
  CalculatorVariable({this.value});

  final String value;
}

abstract class MathOperator {}

class CalculatorAdd extends CalculatorVariable with MathOperator {
  String value = '+';
}

class CalculatorMultiply extends CalculatorVariable with MathOperator {
  String value = '*';
}

class CalculatorDivide extends CalculatorVariable with MathOperator {
  String value = '/';
}

class CalculatorDeduct extends CalculatorVariable with MathOperator {
  String value = '-';
}

class CalculatorNumber extends CalculatorVariable {
  CalculatorNumber(this.value);

  final String value;
}

bool isInteger(num value) {
  return value is int || value == value.roundToDouble();
}
