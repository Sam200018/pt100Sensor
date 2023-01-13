import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt100/screen/utils.dart';

import '../blocs/sensors_bloc.dart';

class TemperaturePage extends StatelessWidget {
  const TemperaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SensorsBloc, SensorsState>(
        builder: (context, state) {
          if (state is DevicesScan) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: 10,
                ),
                Text("Buscando dispositivos..."),
              ],
            );
          } else if (state is StopScanning) {
            return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) => DeviceTile(
                state.results[index].device.name ?? "Unknown",
                state.results[index].device.address,
                () {
                  var address = state.results[index].device.address;
                  context.read<SensorsBloc>().add(ConnectDevice(address));
                },
              ),
            );
          } else if (state is Lecture) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "${state.temperature}°C",
                    style: const TextStyle(fontSize: 50.0),
                  ),
                ),
                Text("Bin:${state.bin}"),
              ],
            );
          }
          return const Center(
            child: Text("Inicia el escaneo con el boton"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.bluetooth_audio_rounded),
        onPressed: () {
          context.read<SensorsBloc>().add(StarScanning());
        },
      ),
    );
  }
}
