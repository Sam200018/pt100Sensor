part of 'sensors_bloc.dart';

abstract class SensorsState extends Equatable {
  const SensorsState();
}

class SensorsInitial extends SensorsState {
  @override
  List<Object> get props => [];
}

class DevicesScan extends SensorsState {
  @override
  List<Object?> get props => [];
}

class StopScanning extends SensorsState {
  final List<BluetoothDiscoveryResult> results;

  const StopScanning(this.results);

  @override
  List<Object?> get props => [results];
}

class Lecture extends SensorsState {
  final String temperature;
  final String bin;

  const Lecture(this.temperature, this.bin);

  @override
  List<Object?> get props => [temperature,bin];

}
