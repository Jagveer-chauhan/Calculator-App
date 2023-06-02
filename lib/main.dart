import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  static const fontColor = Color(0xffD9802E);
  static const bgColor = Color(0xff191919);
  static const operatorbtnColor = Color(0xff272727);

  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  void result(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
      if (hideInput) {
        output = output.substring(0, output.length - 1);
      }
    } else if (value == '=') {
      if (input.endsWith("/") ||
          input.endsWith("x") ||
          input.endsWith("-") ||
          input.endsWith("+") ||
          input.endsWith("%") ||
          input.endsWith(".")) {
        input = input.substring(0, input.length - 1);
      }
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        input = output;
        hideInput = true;
        outputSize = 52.0;
      }
    } else {
      if ((input.endsWith("/") ||
              input.endsWith("x") ||
              input.endsWith("-") ||
              input.endsWith("+") ||
              input.endsWith("%") ||
              input.endsWith(".")) &&
          ((value == "/") ||
              (value == "x") ||
              (value == "-") ||
              (value == "+") ||
              (value == "%") ||
              (value == "."))) {
        input = input.substring(0, input.length - 1);
        input = input + value;
      } else {
        input = input + value;
      }
      hideInput = false;
      outputSize = 34.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                ),
              ),
              button(
                buttonText: "AC",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
              button(
                buttonText: "<",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
              button(
                buttonText: "/",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
            ],
          ),
          Row(
            children: [
              button(
                buttonText: "7",
              ),
              button(buttonText: "8"),
              button(
                buttonText: "9",
              ),
              button(
                buttonText: "x",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
            ],
          ),
          Row(
            children: [
              button(
                buttonText: "4",
              ),
              button(
                buttonText: "5",
              ),
              button(
                buttonText: "6",
              ),
              button(
                buttonText: "-",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
            ],
          ),
          Row(
            children: [
              button(
                buttonText: "1",
              ),
              button(
                buttonText: "2",
              ),
              button(
                buttonText: "3",
              ),
              button(
                buttonText: "+",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
            ],
          ),
          Row(
            children: [
              button(
                buttonText: "%",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
              button(
                buttonText: "0",
              ),
              button(
                buttonText: ".",
                txtColor: fontColor,
                btnColor: operatorbtnColor,
              ),
              button(
                buttonText: "=",
                btnColor: fontColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget button({buttonText, txtColor = Colors.white, btnColor = bgColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(20),
            backgroundColor: btnColor,
          ),
          onPressed: () => result(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20,
              color: txtColor,
              fontWeight: FontWeight.bold,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ),
      ),
    );
  }
}
