/// Program: Basic Calculator Function with Multi-step Operations and Continuous Mode
/// Author: Justin Monubi Ogenche

import 'dart:io';

void main() {
  double? previousResult;
  bool continueRunning = true;

  while (continueRunning) {
    try {
      stdout.write('Choose mode: (1) Simple operation or (2) Multi-step expression (3) Exit: ');
      String? mode = stdin.readLineSync();

      if (mode == '3') {
        continueRunning = false;
        print('Exiting the calculator. Goodbye!');
        break;
      }

      double a;
      if (previousResult != null && (mode == '1' || mode == '2')) {
        stdout.write('Use previous result ($previousResult) as the first operand? (y/n): ');
        String? usePrevious = stdin.readLineSync();
        if (usePrevious?.toLowerCase() == 'y') {
          a = previousResult;
        } else {
          stdout.write('Enter the first operand: ');
          String? num1 = stdin.readLineSync();
          a = double.parse(num1!);
        }
      } else {
        stdout.write('Enter the first operand: ');
        String? num1 = stdin.readLineSync();
        a = double.parse(num1!);
      }

      if (mode == '1') {
        performSimpleOperation(a);
      } else if (mode == '2') {
        previousResult = performMultiStepOperation();
      } else {
        print('Error: Invalid mode selected');
      }
    } catch (e) {
      print(e);
    }
  }
}

void performSimpleOperation(double a) {
  print('Available operators:');
  for (var key in operatorFunc.keys) {
    print(key);
  }

  stdout.write('Enter the operator (+, -, *, /, %): ');
  String? operator = stdin.readLineSync();

  stdout.write('Enter the second operand: ');
  String? num2 = stdin.readLineSync();
  double b = double.parse(num2!);

  if (!operatorFunc.containsKey(operator)) {
    throw Exception('Error: Invalid operator');
  }

  Function calcFunc = operatorFunc[operator]!;
  double result = calcFunc(a, b);
  print('$a $operator $b = $result');
}

double performMultiStepOperation() {
  stdout.write('Enter an expression (e.g., 3 + 5 * 2 - 8 / 4): ');
  String? expression = stdin.readLineSync();

  if (expression != null) {
    double result = evaluateExpression(expression);
    print('Result: $result');
    return result;
  } else {
    print('Error: No expression provided');
    return 0.0;
  }
}

double evaluateExpression(String expression) {
  // Remove spaces from the expression for easier processing
  expression = expression.replaceAll(' ', '');

  // Use regular expressions to split the expression into numbers and operators
  RegExp exp = RegExp(r'(\d+(\.\d+)?)|([\+\-\*/%])');
  Iterable<Match> matches = exp.allMatches(expression);

  List<String> tokens = matches.map((match) => match.group(0)!).toList();
  
  // Stack for numbers
  List<double> numbers = [];

  // Stack for operators
  List<String> operators = [];

  for (var token in tokens) {
    if (double.tryParse(token) != null) {
      // If token is a number, push it to the numbers stack
      numbers.add(double.parse(token));
    } else {
      // If token is an operator, handle it according to precedence
      while (operators.isNotEmpty && precedence(operators.last) >= precedence(token)) {
        double b = numbers.removeLast();
        double a = numbers.removeLast();
        String op = operators.removeLast();
        numbers.add(calculate(a, b, op));
      }
      operators.add(token);
    }
  }

  // Process remaining operators
  while (operators.isNotEmpty) {
    double b = numbers.removeLast();
    double a = numbers.removeLast();
    String op = operators.removeLast();
    numbers.add(calculate(a, b, op));
  }

  // The final result is the last remaining number
  return numbers.last;
}

int precedence(String operator) {
  switch (operator) {
    case '+':
    case '-':
      return 1;
    case '*':
    case '/':
    case '%':
      return 2;
    default:
      throw Exception('Error: Invalid operator $operator');
  }
}

double calculate(double a, double b, String operator) {
  switch (operator) {
    case '+':
      return add(a, b);
    case '-':
      return subtract(a, b);
    case '*':
      return multiply(a, b);
    case '/':
      return divide(a, b);
    case '%':
      return modulus(a, b);
    default:
      throw Exception('Error: Invalid operator');
  }
}

double add(double a, double b) => a + b;
double subtract(double a, double b) => a - b;
double multiply(double a, double b) => a * b;
double divide(double a, double b) {
  if (b == 0) {
    throw Exception('Error: Division by zero');
  }
  return a / b;
}
double modulus(double a, double b) {
  if (b == 0) {
    throw Exception('Error: Division by zero');
  }
  return a % b;
}

Map<String, Function> operatorFunc = {
  '+': add,
  '-': subtract,
  '*': multiply,
  '/': divide,
  '%': modulus,
};
