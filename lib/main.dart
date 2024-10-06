import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String displayText = '0'; // Display area text
  String operand1 = '';
  String operand2 = '';
  String operator = '';

  // Method to update the display area
  void updateDisplay(String value) {
    setState(() {
      if (operator.isEmpty) {
        operand1 += value;
        displayText = operand1;
      } else {
        operand2 += value;
        displayText = operand2;
      }
    });
  }

  // Method to handle arithmetic operations
  void calculateResult() {
    double num1 = double.tryParse(operand1) ?? 0;
    double num2 = double.tryParse(operand2) ?? 0;
    double result = 0;

    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          displayText = 'Error';
          return;
        }
        break;
    }

    setState(() {
      displayText = result.toString();
      operand1 = result.toString();
      operand2 = '';
      operator = '';
    });
  }

  // Method to handle operator input
  void inputOperator(String op) {
    setState(() {
      if (operand1.isNotEmpty) {
        operator = op;
      }
    });
  }

  // Clear button to reset the calculator
  void clear() {
    setState(() {
      operand1 = '';
      operand2 = '';
      operator = '';
      displayText = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          buildButtonRow('7', '8', '9', '/'),
          buildButtonRow('4', '5', '6', '*'),
          buildButtonRow('1', '2', '3', '-'),
          buildButtonRow('0', '.', '=', '+'),
          buildButtonRow('C'), // Clear button
        ],
      ),
    );
  }

  // Helper method to create rows of buttons
  Row buildButtonRow(String btn1, [String? btn2, String? btn3, String? btn4]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildButton(btn1),
        if (btn2 != null) buildButton(btn2),
        if (btn3 != null) buildButton(btn3),
        if (btn4 != null) buildButton(btn4),
      ],
    );
  }

  // Helper method to create individual buttons
  Widget buildButton(String text) {
    return InkWell(
      onTap: () {
        if (text == 'C') {
          clear();
        } else if (text == '=') {
          calculateResult();
        } else if (['+', '-', '*', '/'].contains(text)) {
          inputOperator(text);
        } else {
          updateDisplay(text);
        }
      },
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: Text(text, style: TextStyle(fontSize: 28)),
      ),
    );
  }
}
