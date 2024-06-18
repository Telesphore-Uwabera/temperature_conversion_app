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
  _TemperatureConverterHomePageState createState() =>
      _TemperatureConverterHomePageState();
}

class _TemperatureConverterHomePageState
    extends State<TemperatureConverterHomePage> {
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
      _history.insert(
          0, '$conversionType: ${value.toStringAsFixed(1)} => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature Converter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          constraints: BoxConstraints(maxWidth: 600), // Adjust maxWidth as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              'Fahrenheit to Celsius',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
                            Text(
                              'Celsius to Fahrenheit',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Enter temperature',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '=',
                    style: TextStyle(fontSize: 36),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          _result,
                          style: TextStyle(fontSize: 36),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convert,
                child: Text(
                  'CONVERT',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _history
                        .map(
                          (conversion) => Text(
                            conversion,
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
