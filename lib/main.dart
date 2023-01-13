import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:pt100/blocs/sensors_bloc.dart';
import 'package:pt100/screen/temperature_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterBluetoothSerial flutterBlue = FlutterBluetoothSerial.instance;
    return  MaterialApp(
      home: BlocProvider(
        create: (context) => SensorsBloc(flutterBlue),
        child: const TemperaturePage(),
      ),
    );
  }
}
