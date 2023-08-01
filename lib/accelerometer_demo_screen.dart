import 'dart:async';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class AccelerometerDemoScreen extends StatefulWidget {
  const AccelerometerDemoScreen({super.key});

  @override
  State<AccelerometerDemoScreen> createState() =>
      _AccelerometerDemoScreenState();
}

class _AccelerometerDemoScreenState extends State<AccelerometerDemoScreen> {
  List<double>? _userAccelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Map<String, List<double>> userAccelData = {
    '00:00': [0, 0, 0]
  };

  void accelSubscribe() {
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
            userAccelData[DateFormat.Hms().format(DateTime.now())] =
                _userAccelerometerValues!;
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Accelerometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }

  void accelDispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void showData() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ...userAccelData.entries.map((el) => ListTile(
                        title: Text(el.key),
                        subtitle: Text(el.value.toString()),
                      )),
                  ElevatedButton(
                    child: const Text('Close BottomSheet'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void generateCsvFile() async {
    /*Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();*/
    PermissionStatus storageStatus;
    PermissionStatus manageStorageStatus;
    storageStatus = await Permission.storage.request();
    manageStorageStatus = await Permission.manageExternalStorage.request();
    // print(storageStatus);

    List<List<dynamic>> rows = [];

    List<dynamic> row = [];
    row.add("Time");
    row.add("xyz");
    rows.add(row);

    for (var el in userAccelData.entries) {
      List<dynamic> row = [];
      row.add(el.key);
      row.add(el.value[0]);
      row.add(el.value[1]);
      row.add(el.value[2]);
      rows.add(row);
    }

    /*row.add("number");
    row.add("latitude");
    row.add("longitude");
    rows.add(row);
    for (int i = 0; i < associateList.length; i++) {
      List<dynamic> row = [];
      row.add(associateList[i]["number"] - 1);
      row.add(associateList[i]["lat"]);
      row.add(associateList[i]["lon"]);
      rows.add(row);
    }*/


    String csv = const ListToCsvConverter().convert(rows);
    print(csv);

    Directory? directory;
    directory = Directory('/storage/emulated/0/Download');
    // directory = await getDownloadsDirectory();
    if (!await directory.exists()) directory = await getExternalStorageDirectory();

    String file = directory!.path;
    // print(directory);

    File f = File(file + "/accelDataV3.csv");

    f.writeAsString(csv);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accel demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.blueGrey,
              )),
              child: Text(_userAccelerometerValues.toString())),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: accelSubscribe,
                child: const Text("Subscribe"),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: accelDispose,
                child: const Text("Dispose"),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: showData,
            child: const Text("show data"),
          ),
          ElevatedButton(
            onPressed: generateCsvFile,
            child: Text("save to file lol"),
          ),







          /*SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Аксель'),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SensorsDto, String>>[
                LineSeries<_SensorsDto, String>(
                  dataSource: data,
                  xValueMapper: (_SensorsDto data, _) => DateTime.now().second.toString(),
                  yValueMapper: (_SensorsDto data, _) => data.x,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ]

          )*/
        ],
      ),
    );
  }
}
