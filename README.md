# Temperature Converter App

This is a Flutter application that converts temperatures between Fahrenheit and Celsius. The app features a user-friendly interface allowing users to input a temperature and choose the conversion type, and it displays the converted temperature along with a history of past conversions.

## Features

- **Temperature Conversion**: Convert temperatures from Fahrenheit to Celsius and vice versa.
- **Conversion History**: Maintain a history of conversions performed during the session.
- **Responsive UI**: The app's interface adjusts for different screen sizes.

## Installation

To run this app locally, ensure you have Flutter installed on your machine. Follow these steps:

1. **Clone the repository**:
    ```sh
    git clone https://github.com/Telesphore-Uwabera/temperature_converter_app.git
    cd temperature_converter_app
    ```

2. **Install dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the app**:
    ```sh
    flutter run
    ```

## Usage

1. **Select Conversion Type**: Choose whether to convert from Fahrenheit to Celsius or Celsius to Fahrenheit using the radio buttons.
2. **Enter Temperature**: Input the temperature value you want to convert.
3. **Convert**: Press the "CONVERT" button to see the result.
4. **View History**: Scroll through the history section to see past conversions.

## Code Overview

### Main Entry Point

The main entry point of the app is defined in `main.dart`:

```dart
void main() {
  runApp(TemperatureConverterApp());
}
```

### Application Structure

- **TemperatureConverterApp**: The root widget of the application, setting up the MaterialApp and theme.
- **TemperatureConverterHomePage**: A stateful widget managing the conversion logic and UI.
- **_TemperatureConverterHomePageState**: Contains the state and methods for performing conversions and maintaining history.

### Conversion Logic

The conversion logic is implemented in the `_convert` method:

```dart
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
    _result = convertedValue.toStringAsFixed(1);
    _history.insert(0, '$conversionType: ${value.toStringAsFixed(1)} => $_result');
  });
}
```

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue to discuss improvements or bug fixes.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Enjoy using the Temperature Converter App! If you encounter any issues or have suggestions for improvements, please open an issue on the GitHub repository.
