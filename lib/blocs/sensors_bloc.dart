import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

part 'sensors_event.dart';

part 'sensors_state.dart';

class SensorsBloc extends Bloc<SensorsEvent, SensorsState> {
  final FlutterBluetoothSerial serial;
  StreamSubscription<BluetoothDiscoveryResult>? _devices;

  // StreamSubscription<BluetoothConnection>? connection;
  List<BluetoothDiscoveryResult> results = [];

  SensorsBloc(this.serial) : super(SensorsInitial()) {
    on<ShowInput>(_onShowInputToState);
    on<ConnectDevice>(_onConnectDeviceToState);
    on<LoadedDevices>(_onLoadedDevicesToState);
    on<StarScanning>(_onStarScanningToState);
  }

  Future<void> _onConnectDeviceToState(
      ConnectDevice event, Emitter<SensorsState> emit) async {
    var deviceIsConnect = await serial.isEnabled;
    print(deviceIsConnect);
    if (deviceIsConnect!) {
      String bin = "000000000";
      try {
        var connection = await BluetoothConnection.toAddress(event.address);
        connection.input!.listen((temperature) {
          List<String> lecture = utf8.decode(temperature).toString().split(" ");
          if (lecture[0]=="") {

            add(ShowInput(lecture[1],bin));
          } else {
            bin=lecture[0];
            add(ShowInput(lecture[1], lecture[0]));
          }
        });
      } catch (e) {
        // print(e);
      }
    }
  }

  @override
  Future<void> close() {
    _devices?.cancel();
    return super.close();
  }

  void _onLoadedDevicesToState(
      LoadedDevices event, Emitter<SensorsState> emit) {
    emit(StopScanning(event.results));
  }

  Future<void> _onStarScanningToState(
      StarScanning event, Emitter<SensorsState> emit) async {
    emit(DevicesScan());
    _devices = serial.startDiscovery().listen((r) {
      final existingIndex = results
          .indexWhere((element) => element.device.address == r.device.address);
      if (existingIndex >= 0) {
        results[existingIndex] = r;
      } else {
        results.add(r);
      }
    });

    await Future.delayed(const Duration(seconds: 30)).then((value) {
      emit(StopScanning(results));
    });
  }

  void _onShowInputToState(ShowInput event, Emitter<SensorsState> emit) {
    emit(Lecture(event.temperature, event.bin));
  }
}
