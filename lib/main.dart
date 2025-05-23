import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  String userInput = '';
  String result = '';

  void handleButtonPress(String text) {
    setState(() {
      if (text == 'C') {
        userInput = '';
        result = '';
      } else if (text == 'DEL') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (text == '=') {
        try {
          String finalInput = userInput.replaceAll('x', '*');
          result = '= ${_evaluate(finalInput)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        userInput += text;
      }
    });
  }

  String _evaluate(String expression) {
    try {
      expression = expression.replaceAll('x', '*').replaceAll('%', '/100');
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Invalid';
    }
  }

  bool isOperator(String x) {
    return ['%', '/', 'x', '-', '+', '='].contains(x);
  }

  Color getButtonColor(String text) {
    return isOperator(text) ? Colors.deepPurple : Colors.deepPurple[50]!;
  }

  Color getTextColor(String text) {
    return isOperator(text) ? Colors.white : Colors.deepPurple;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'ZACKI ABDULKADIR OMER',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
            double buttonHeight = screenHeight < 650 ? 60 : 80;
            double fontSize = screenHeight < 650 ? 16 : 22;

            return Column(
              children: <Widget>[
                // Display
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userInput,
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          result,
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    itemCount: buttons.length,
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      return MyButton(
                        text: buttons[index],
                        color: getButtonColor(buttons[index]),
                        textColor: getTextColor(buttons[index]),
                        height: buttonHeight,
                        fontSize: fontSize,
                        onTap: () => handleButtonPress(buttons[index]),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
