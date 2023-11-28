import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 38.0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
         resultFontSize = 38.0;
      } else if (buttonText == "=") {
        expression=equation;
        expression=expression.replaceAll('×', "*");
        expression=expression.replaceAll('÷', "/");

        try{
          Parser parser=Parser();
          Expression exp=parser.parse(expression);
          ContextModel cm= ContextModel();
          result='${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result="Error";

        }
      } else if (buttonText == "⇽") {
        equation = equation.substring(0, equation.length - 1);
        equationFontSize = 38.0;
        resultFontSize = 38.0;
        if(equation==""){
          equation="0";
        }
      } else {
        if(equation=="0"){
          equation=buttonText;
        }else{
          equation=equation+buttonText;
        }
      }
    });
  }

  Widget BuildButon(String buttonText, double ButtonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * ButtonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => _buttonPressed(buttonText),
        child: Text(buttonText,
            style: const TextStyle(color: Colors.blue, fontSize: 35)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          const Expanded(child: Divider()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Table(
                  children: [
                    TableRow(children: [
                      BuildButon("×", 1, Colors.redAccent),
                      BuildButon("÷", 1, Colors.redAccent),
                      BuildButon("+", 1, Colors.redAccent),
                      BuildButon("-", 1, Colors.redAccent),
                    ])
                  ],
                ),
              ),
              Container(
                child: Table(
                  children: [
                    TableRow(children: [
                      BuildButon("1", 1, Colors.redAccent),
                      BuildButon("2", 1, Colors.redAccent),
                      BuildButon("3", 1, Colors.redAccent),
                    ]),
                    TableRow(children: [
                      BuildButon("4", 1, Colors.redAccent),
                      BuildButon("5", 1, Colors.redAccent),
                      BuildButon("6", 1, Colors.redAccent),
                    ]),
                    TableRow(children: [
                      BuildButon("7", 1, Colors.redAccent),
                      BuildButon("8", 1, Colors.redAccent),
                      BuildButon("9", 1, Colors.redAccent),
                    ]),
                    TableRow(children: [
                      BuildButon("C", 1, Colors.redAccent),
                      BuildButon("⇽", 1, Colors.redAccent),
                      BuildButon("=", 1, Colors.redAccent),
                    ]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
