import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverterHomePage(),
    );
  }
}

class TemperatureConverterHomePage extends StatefulWidget {
  @override
  _TemperatureConverterHomePageState createState() => _TemperatureConverterHomePageState();
}

class _TemperatureConverterHomePageState extends State<TemperatureConverterHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  List<String> _history = [];
  bool _isFtoC = true;

  void _convert() {
    final input = _controller.text;
    if (input.isEmpty) {
      setState(() {
        _result = 'Please enter a value';
      });
      return;
    }

    final value = double.tryParse(input);
    if (value == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    double convertedValue;
    String conversionType;
    if (_isFtoC) {
      convertedValue = (value - 32) * 5 / 9;
      conversionType = 'F to C';
    } else {
      convertedValue = value * 9 / 5 + 32;
      conversionType = 'C to F';
    }

    setState(() {
      _result = convertedValue.toStringAsFixed(2);
      _history.insert(0, '$conversionType: ${value.toStringAsFixed(1)} => ${_result}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Converter',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 20.0,
              alignment: WrapAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _isFtoC,
                      onChanged: (value) {
                        setState(() {
                          _isFtoC = value!;
                        });
                      },
                    ),
                    Text('Fahrenheit to Celsius'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<bool>(
                      value: false,
                      groupValue: _isFtoC,
                      onChanged: (value) {
                        setState(() {
                          _isFtoC = value!;
                        });
                      },
                    ),
                    Text('Celsius to Fahrenheit'),
                  ],
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('CONVERT'),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _history.map((conversion) => Text(conversion)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
