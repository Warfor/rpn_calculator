import 'package:flutter/material.dart';
import 'calculator.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String stack = 'Stack: ';
  String input = 'Input: ';
  String result = 'Result: ';
  RPNCalculator calculator = RPNCalculator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  stack,
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  input,
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  result,
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildNumberButton('7'),
                  _buildNumberButton('8'),
                  _buildNumberButton('9'),
                  _buildOperationButton('*'),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildNumberButton('4'),
                  _buildNumberButton('5'),
                  _buildNumberButton('6'),
                  _buildOperationButton('-'), // Changed to match RPN operator
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildNumberButton('1'),
                  _buildNumberButton('2'),
                  _buildNumberButton('3'),
                  _buildOperationButton('+'), // Changed to match RPN operator
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildNumberButton('0'),
                  _buildFunctionButton('Clear'),
                  _buildOperationButton('Enter'),
                  _buildOperationButton('/'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            input += label;
          });
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[600],
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  Widget _buildOperationButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (label == 'Enter') {
              try {
                double value =
                    double.parse(input.replaceAll('Input: ', '').trim());
                calculator.push(value);
                stack = 'Stack: ${calculator.stack}';
                input = '';
                result = 'Result: ';
              } catch (e) {
                result = 'Result: Error';
                print('Result: $e');
              }
            } else if (calculator.stack.length >= 2) {
              if (label.isNotEmpty) {
                try {
                  double value = double.parse(label);
                  calculator.push(value);
                  stack = 'Stack: ${calculator.stack}';
                } catch (e) {
                  result = 'Result: Error';
                  //print('Result: $e');
                }
              }
              calculator.calculate(label);
              result = 'Result: ${calculator.peek()}';
              input = '';
            } else {
              result = 'Result: Error - Insufficient operands for operator';
            }
          });
        },
        style: ElevatedButton.styleFrom(
          primary: label == 'Enter' ? Colors.blue : Colors.green,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  Widget _buildFunctionButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (label == 'Clear') {
              input = 'Input: ';
              result = 'Result: ';
              stack = 'Stack: ';
              calculator.clear();
            }
          });
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue[400],
          onPrimary: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Calculator App',
    home: CalculatorScreen(),
  ));
}
