import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,    
      ),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false, // Add this line to remove the debug banner
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _operand = '';
  double _firstOperand = 0;
  double _secondOperand = 0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clear();
      } else if (buttonText == '=' && _operand.isNotEmpty) {
        _calculateResult();
      } else if ('+-x/'.contains(buttonText)) {
        _setOperand(buttonText);
      } else {
        _updateDisplay(buttonText);
      }
    });
  }

  void _clear() {
    _display = '0';
    _operand = '';
    _firstOperand = 0;
    _secondOperand = 0;
  }

  void _setOperand(String operand) {
    if (_operand.isEmpty) {
      _firstOperand = double.tryParse(_display) ?? 0;
      _operand = operand;
      _display = '0';
    }
  }

  void _updateDisplay(String text) {
    if (_display == '0') {
      _display = text;
    } else {
      _display += text;
    }
  }

  void _calculateResult() {
    _secondOperand = double.tryParse(_display) ?? 0;
    double result = 0;

    switch (_operand) {
      case '+':
        result = _firstOperand + _secondOperand;
        break;
      case '-':
        result = _firstOperand - _secondOperand;
        break;
      case 'x':
        result = _firstOperand * _secondOperand;
        break;
      case '/':
        result = _firstOperand / _secondOperand;
        break;
    }

    _display = result.toString();
    _operand = '';
    _firstOperand = result;
    _secondOperand = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              _buildButtonRow(['7', '8', '9', '/']),
              _buildButtonRow(['4', '5', '6', 'x']),
              _buildButtonRow(['1', '2', '3', '-']),
              _buildButtonRow(['C', '0', '=', '+']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return _buildButton(button);
      }).toList(),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            shape: const CircleBorder(),
            backgroundColor: _getButtonColor(text),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String text) {
    if (text == 'C') {
      return Colors.blueGrey;
    } else if (text == '=' || text == '/' || text == 'x' || text == '-' || text == '+') {
      return Colors.blue;
    } else {
      return Colors.grey[850]!;
    }
  }
}
