// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calc/calculator.dart';
import 'package:rpn_calc/main.dart';

void main() {
  test('addition RPNCalculator Test', () {
    // Create an instance of the calculator
    RPNCalculator calculator = RPNCalculator();

    // Define the sample RPN expression
    String expression = '199 2 +';

    // Calculate the result
    double result = calculator.calculateRPN(expression);

    // Verify that the result is correct
    expect(result, equals(201));
  });

  test('subtraction RPNCalculator Test', () {
    // Create an instance of the calculator
    RPNCalculator calculator = RPNCalculator();

    // Define the sample RPN expression
    String expression = '2 6 -';

    // Calculate the result
    double result = calculator.calculateRPN(expression);

    // Verify that the result is correct
    expect(result, equals(-4.0));
  });

  test('division RPNCalculator Test', () {
    // Create an instance of the calculator
    RPNCalculator calculator = RPNCalculator();

    // Define the sample RPN expression
    String expression = '12 6 /';

    // Calculate the result
    double result = calculator.calculateRPN(expression);

    // Verify that the result is correct
    expect(result, equals(2.0));
  });

  test('multiplikation RPNCalculator Test', () {
    // Create an instance of the calculator
    RPNCalculator calculator = RPNCalculator();

    // Define the sample RPN expression
    String expression = '4 6 *';

    // Calculate the result
    double result = calculator.calculateRPN(expression);

    // Verify that the result is correct
    expect(result, equals(24.0));
  });

  test('multiplikation 0 RPNCalculator Test', () {
    // Create an instance of the calculator
    RPNCalculator calculator = RPNCalculator();

    // Define the sample RPN expression
    String expression = '42 0 *';

    // Calculate the result
    double result = calculator.calculateRPN(expression);

    // Verify that the result is correct
    expect(result, equals(0.0));
  });

  test('division RPNCalculator Test', () {
    // Create an instance of the calculator
    RPNCalculator calculator = RPNCalculator();

    // Define the sample RPN expression
    String expression = '0 6 /';

    // Calculate the result
    double result = calculator.calculateRPN(expression);

    // Verify that the result is correct
    expect(result, equals(0));
  });

}



