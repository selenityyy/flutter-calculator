import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _result = '';

  final List<String> _currencies = ['USD', 'EUR', 'JPY', 'GBP'];

  void _convertCurrency() {
    // Hard-coded exchange rates for simplicity
    final rates = {
      'USD': {'EUR': 0.85, 'JPY': 110.0, 'GBP': 0.75},
      'EUR': {'USD': 1.18, 'JPY': 129.0, 'GBP': 0.88},
      'JPY': {'USD': 0.0091, 'EUR': 0.0078, 'GBP': 0.0068},
      'GBP': {'USD': 1.33, 'EUR': 1.14, 'JPY': 150.0},
    };

    final amount = double.tryParse(_amountController.text);
    if (amount != null) {
      final rate = rates[_fromCurrency]?[_toCurrency] ?? 1.0;
      final result = amount * rate;
      setState(() {
        _result = result.toStringAsFixed(2);
      });
    } else {
      setState(() {
        _result = 'Invalid amount';
      });
    }
  }

  void _performModuloOperation() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null) {
      final result = amount %
          2; // You can modify this to any number you want to use for the modulo operation
      setState(() {
        _result = result.toStringAsFixed(2);
      });
    } else {
      setState(() {
        _result = 'Invalid amount';
      });
    }
  }

  void _clearFields() {
    setState(() {
      _amountController.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value!;
                    });
                  },
                  items: _currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value!;
                    });
                  },
                  items: _currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performModuloOperation,
              child: const Text('Modulo'),
            ),
            const SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _clearFields,
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}
