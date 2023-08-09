import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';

// This flutter app demonstrates an usage of the flutter_reactive_ble flutter plugin
// This app works only with BLE devices which advertise with a Nordic UART Service (NUS) UUID
Uuid _UART_UUID = Uuid.parse("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
Uuid _UART_RX = Uuid.parse("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");
Uuid _UART_TX = Uuid.parse("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");

@RoutePage()
class BleExampleScreen extends StatefulWidget {
  BleExampleScreen({super.key, required this.title});

  final String title;

  @override
  _BleExampleScreenState createState() => _BleExampleScreenState();
}

class _BleExampleScreenState extends State<BleExampleScreen> {
  final flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> _foundBleUARTDevices = [];
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late Stream<ConnectionStateUpdate> _currentConnectionStream;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  late QualifiedCharacteristic _txCharacteristic;
  late QualifiedCharacteristic _rxCharacteristic;
  late Stream<List<int>> _receivedDataStream;
  late TextEditingController _dataToSendText;
  bool _scanning = false;
  bool _connected = false;
  String _logTexts = "";
  List<String> _receivedData = [];
  int _numberOfMessagesReceived = 0;

  void logger() {}

  void initState() {
    super.initState();
    _dataToSendText = TextEditingController();
  }

  void refreshScreen() {
    setState(() {});
  }

  void _sendData() async {
    await flutterReactiveBle.writeCharacteristicWithResponse(_rxCharacteristic,
        value: _dataToSendText.text.codeUnits);
  }

  void onNewReceivedData(List<int> data) {
    _numberOfMessagesReceived += 1;
    _receivedData
        .add("$_numberOfMessagesReceived: ${String.fromCharCodes(data)}");
    if (_receivedData.length > 5) {
      _receivedData.removeAt(0);
    }
    refreshScreen();
  }

  void _disconnect() async {
    await _connection.cancel();
    _connected = false;
    refreshScreen();
  }

  void _stopScan() async {
    await _scanStream.cancel();
    _scanning = false;
    refreshScreen();
  }

  Future<void> showNoPermissionDialog() async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No location permission '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('No location permission granted.'),
                const Text(
                    'Location permission is required for BLE to function.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Acknowledge'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  void _startScan() async {
    bool goForIt = false;
    PermissionStatus permissionStatus;
    PermissionStatus permissionStatusBlueToothScan;
    PermissionStatus permissionStatusBlueToothConnect;
    PermissionStatus permissionStatusBlueTooth;
    if (Platform.isAndroid) {
      permissionStatus = await Permission.location.request();
      permissionStatusBlueToothScan = await Permission.bluetoothScan.request();
      permissionStatusBlueToothConnect =
          await Permission.bluetoothConnect.request();
      permissionStatusBlueTooth = await Permission.bluetoothAdvertise.request();
      print("android permission status location $permissionStatus");
      print(
          "android permission status bluetooth $permissionStatusBlueToothScan");
      print(
          "android permission status bluetooth $permissionStatusBlueToothConnect");
      print("android permission status bluetooth $permissionStatusBlueTooth");
      if (permissionStatus == PermissionStatus.granted) {
        goForIt = true;
      }
    } else if (Platform.isIOS) {
      permissionStatus = await Permission.location.request();
      print("ios permission status $permissionStatus");
      goForIt = true;
    }
    if (goForIt) {
      //TODO replace True with permission == PermissionStatus.granted is for IOS test
      _foundBleUARTDevices = [];
      _scanning = true;
      refreshScreen();
      _scanStream = flutterReactiveBle.scanForDevices(
        withServices: [],
        requireLocationServicesEnabled: false,
      ).listen((device) {
        if (_foundBleUARTDevices.every((element) => element.id != device.id)) {
          _foundBleUARTDevices.add(device);
          refreshScreen();
        }
        if (device.name == 'Radioland iBeacon') {
          print(DateTime.now());
          print(device.name);
          print(device.rssi);
        }

        /*for (var device in _foundBleUARTDevices) {
          print(device.name);
          print(device.rssi);
        }*/
      }, onError: (Object error) {
        _logTexts = "${_logTexts}ERROR while scanning:$error \n";
        refreshScreen();
      });
    } else {
      await showNoPermissionDialog();
    }
  }

  void onConnectDevice(index) {
    _currentConnectionStream = flutterReactiveBle.connectToAdvertisingDevice(
      id: _foundBleUARTDevices[index].id,
      prescanDuration: Duration(seconds: 1),
      withServices: [_UART_UUID, _UART_RX, _UART_TX],
    );
    _logTexts = "";
    refreshScreen();
    _connection = _currentConnectionStream.listen((event) {
      var id = event.deviceId.toString();
      switch (event.connectionState) {
        case DeviceConnectionState.connecting:
          {
            _logTexts = "${_logTexts}Connecting to $id\n";
            break;
          }
        case DeviceConnectionState.connected:
          {
            _connected = true;
            _logTexts = "${_logTexts}Connected to $id\n";
            _numberOfMessagesReceived = 0;
            _receivedData = [];
            _txCharacteristic = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _UART_TX,
                deviceId: event.deviceId);
            _receivedDataStream =
                flutterReactiveBle.subscribeToCharacteristic(_txCharacteristic);
            _receivedDataStream.listen((data) {
              onNewReceivedData(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _rxCharacteristic = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _UART_RX,
                deviceId: event.deviceId);
            break;
          }
        case DeviceConnectionState.disconnecting:
          {
            _connected = false;
            _logTexts = "${_logTexts}Disconnecting from $id\n";
            break;
          }
        case DeviceConnectionState.disconnected:
          {
            _logTexts = "${_logTexts}Disconnected from $id\n";
            break;
          }
      }
      refreshScreen();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text("BLE UART Devices found:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  height: 350,
                  child: ListView.builder(
                      itemCount: _foundBleUARTDevices.length,
                      itemBuilder: (context, index) => Card(
                              child: ListTile(
                            dense: true,
                            enabled: !((!_connected && _scanning) ||
                                (!_scanning && _connected)),
                            trailing: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                (!_connected && _scanning) ||
                                        (!_scanning && _connected)
                                    ? () {}
                                    : onConnectDevice(index);
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                alignment: Alignment.center,
                                child: const Icon(Icons.add_link),
                              ),
                            ),
                            title: Text(
                                "$index: ${_foundBleUARTDevices[index].name}"),
                            subtitle: Column(
                              children: [
                                Text('id: ${_foundBleUARTDevices[index].id}\n'),
                                Text('connectable: ${_foundBleUARTDevices[index].connectable.toString()}\n'),
                                Text('manufacture data ${_foundBleUARTDevices[index].manufacturerData.toString()}\n'),
                                Text('rssi ${_foundBleUARTDevices[index].rssi}\n'),
                                Text('service uuids ${_foundBleUARTDevices[index].serviceUuids}\n'),
                                Text('serviceData ${_foundBleUARTDevices[index].serviceData}\n'),
                              ],
                            ),
                          )))),
              const Text("Status messages:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  width: 1400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  height: 90,
                  child: Scrollbar(
                      child: SingleChildScrollView(child: Text(_logTexts)))),
              const Text("Received data:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  width: 1400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  height: 90,
                  child: Text(_receivedData.join("\n"))),
              const Text("Send message:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: TextField(
                      enabled: _connected,
                      controller: _dataToSendText,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Enter a string'),
                    )),
                    ElevatedButton(
                        child: Icon(
                          Icons.send,
                          color: _connected ? Colors.blue : Colors.grey,
                        ),
                        onPressed: _connected ? _sendData : () {}),
                  ]))
            ],
          ),
        ),
        persistentFooterButtons: [
          Container(
            height: 35,
            child: Column(
              children: [
                if (_scanning)
                  const Text("Scanning: Scanning")
                else
                  const Text("Scanning: Idle"),
                if (_connected)
                  const Text("Connected")
                else
                  const Text("disconnected."),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: !_scanning && !_connected ? _startScan : () {},
            child: Icon(
              Icons.play_arrow,
              color: !_scanning && !_connected ? Colors.blue : Colors.grey,
            ),
          ),
          ElevatedButton(
              onPressed: _scanning ? _stopScan : () {},
              child: Icon(
                Icons.stop,
                color: _scanning ? Colors.blue : Colors.grey,
              )),
          ElevatedButton(
              onPressed: _connected ? _disconnect : () {},
              child: Icon(
                Icons.cancel,
                color: _connected ? Colors.blue : Colors.grey,
              ))
        ],
      );
}
