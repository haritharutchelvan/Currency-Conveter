import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatefulWidget {
  // Add a named 'key' parameter to the constructor
  const CurrencyConverterApp({Key? key}) : super(key: key);

  @override
  _CurrencyConverterAppState createState() => _CurrencyConverterAppState();
}

class _CurrencyConverterAppState extends State<CurrencyConverterApp> {
  Map<String, dynamic> _exchangeRates = {};
  double _amount = 1.0;
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _result = 0.0;

  @override
  void initState() {
    super.initState();
    _loadExchangeRates();
  }

  Future<void> _loadExchangeRates() async {
    String jsonString = await rootBundle.loadString('assets/currencies.json');
    setState(() {
      _exchangeRates = json.decode(jsonString);
    });
  }

  void _convertCurrency() {
    double fromRate = _exchangeRates[_fromCurrency];
    double toRate = _exchangeRates[_toCurrency];
    double result = (_amount / fromRate) * toRate;
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Currency Converter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Currency Converter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('From:'),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _fromCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    },
                    items: _exchangeRates.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('To:'),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _toCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    },
                    items: _exchangeRates.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Amount:'),
              SizedBox(height: 10),
              Container(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _amount = double.tryParse(value) ?? 0.0;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Amount',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _convertCurrency();
                },
                child: Text('Convert'),
              ),
              SizedBox(height: 20),
              Text('Result: $_result $_toCurrency'),
            ],
          ),
        ),
      ),
    );
  }
}
