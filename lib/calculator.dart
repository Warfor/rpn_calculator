import 'dart:math';

class RPNCalculator {
  List<double> stack = [];

  void push(double value) {
    stack.add(value);
  }

  double pop() {
    if (stack.isEmpty) {
      throw StateError('Stack is empty');
    }
    return stack.removeLast();
  }

  double peek() {
    if (stack.isEmpty) {
      throw StateError('Stack is empty');
    }
    return stack.last;
  }

  void clear() {
    stack.clear();
  }

  double calculateRPN(String expression) {
    clear();
    List<String> tokens = _tokenizeExpression(expression);

    for (String token in tokens) {
      if (_isNumber(token)) {
        push(double.parse(token));
      } else if (_isOperator(token)) {
        calculate(token);
      } else {
        throw FormatException('Invalid token: $token');
      }
    }

    if (stack.length != 1) {
      throw FormatException('Invalid expression');
    }

    return pop();
  }

  List<String> _tokenizeExpression(String expression) {
    return expression.split(' ');
  }

  bool _isNumber(String token) {
    return double.tryParse(token) != null;
  }

  bool _isOperator(String token) {
    return token == '+' || token == '-' || token == '*' || token == '/';
  }

  void calculate(String operator) {
    if (stack.length < 2) {
      throw FormatException('Insufficient operands for operator $operator');
    }

    double operand2 = pop();
    double operand1 = pop();

    switch (operator) {
      case '+':
        push(operand1 + operand2);
        break;
      case '-':
        push(operand1 - operand2);
        break;
      case '*':
        push(operand1 * operand2);
        break;
      case '/':
        if (operand2 == 0) {
          throw ArgumentError('Division by zero');
        }
        push(operand1 / operand2);
        break;
      default:
        throw ArgumentError('Invalid operator: $operator');
    }
  }
}
