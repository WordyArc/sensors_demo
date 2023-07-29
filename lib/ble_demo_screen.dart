import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleDemoScreen extends StatefulWidget {
  const BleDemoScreen({super.key});

  @override
  State<BleDemoScreen> createState() => _BleDemoScreenState();
}

class _BleDemoScreenState extends State<BleDemoScreen> {
  final flutterReactiveBle = FlutterReactiveBle();

  void scan() {
    flutterReactiveBle.scanForDevices(withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      print(device);
    }, onError: (e) {
      print("scan error");
    });
  }

  void observeHostDevice() {
    flutterReactiveBle.statusStream.listen((status) {
      //code for handling status update
      print(status);
    });
  }

/*  void establishingConnection() {
    flutterReactiveBle.connectToDevice(
      id: foundDeviceId,
      servicesWithCharacteristicsToDiscover: {serviceId: [char1, char2]},
      connectionTimeout: const Duration(seconds: 2),
    ).listen((connectionState) {
      // Handle connection state updates
    }, onError: (Object error) {
      // Handle a possible error
    });
  }*/

  void readCharacteristic() {
    // final characteristic = QualifiedCharacteristic(serviceId: serviceUuid, characteristicId: characteristicUuid, deviceId: foundDeviceId);
    // final response = await flutterReactiveBle.readCharacteristic(characteristic);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
