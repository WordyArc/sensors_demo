import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class BleDemoScreen extends StatefulWidget {
  const BleDemoScreen({super.key});

  @override
  State<BleDemoScreen> createState() => _BleDemoScreenState();
}

class _BleDemoScreenState extends State<BleDemoScreen> {
  final flutterReactiveBle = FlutterReactiveBle();
  String deviceList = "kek";

  void scan() async {
    PermissionStatus permissionStatusLocation;
    PermissionStatus permissionStatusBluetooth;
    PermissionStatus permissionStatusBluetoothMain;
    PermissionStatus permissionStatusBluetoothAdvice;

    permissionStatusLocation = await Permission.locationAlways.request();
    permissionStatusBluetooth = await Permission.bluetoothScan.request();
    permissionStatusBluetoothMain = await Permission.bluetoothConnect.request();
    permissionStatusBluetoothAdvice = await Permission.bluetoothAdvertise.request();
    print('Location $permissionStatusLocation');
    print('BScan $permissionStatusBluetooth');
    print('Connect $permissionStatusBluetoothMain');
    print('Adv $permissionStatusBluetoothAdvice');
    flutterReactiveBle.scanForDevices(withServices: [], scanMode: ScanMode.balanced).listen((device) async {
      setState(() {
        deviceList = device.toString();
      });

      await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('error $device'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // dismisses only the dialog and returns nothing
            },
            child: Text('OK'),
          ),
        ],
      ),
      );
      print(device);
    }, onError: (e) async {
      deviceList = e.toString();
      print("scan error $e");


      await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('error $e'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // dismisses only the dialog and returns nothing
            },
            child: Text('OK'),
          ),
        ],
      ),
      );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("lol kek"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                scan();
              },
              child: Text("Touch me!"),
            ),
            Text(deviceList),
          ],
        ),
      ),
    );
  }
}
