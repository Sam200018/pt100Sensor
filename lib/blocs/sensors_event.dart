part of 'sensors_bloc.dart';

abstract class SensorsEvent extends Equatable {
  const SensorsEvent();
}

class ConnectDevice extends SensorsEvent {
  final String address;

  const ConnectDevice(this.address);

  @override
  List<Object?> get props => [address];
}

class LoadedDevices extends SensorsEvent {
  final List<BluetoothDiscoveryResult> results;

  const LoadedDevices(this.results);

  @override
  List<Object?> get props => [results];
}

class StarScanning extends SensorsEvent {
  @override
  List<Object?> get props => [];
}

class ShowInput extends SensorsEvent {
  final String temperature;
  final String bin;

  const ShowInput(this.temperature, this.bin);

  @override
  List<Object?> get props => [temperature,bin];
}
