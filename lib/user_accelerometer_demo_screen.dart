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
class UserAccelerometerDemoScreen extends StatefulWidget {
  const UserAccelerometerDemoScreen({super.key});

  @override
  State<UserAccelerometerDemoScreen> createState() =>
      _UserAccelerometerDemoScreenState();
}

class _UserAccelerometerDemoScreenState extends State<UserAccelerometerDemoScreen> {
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
            userAccelData[DateTime.now().toString()] = _userAccelerometerValues!;
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
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Center(
            child: SingleChildScrollView(
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


    List<List<dynamic>> rows = [];

    List<dynamic> row = [];
    row.add("Time");
    row.add("x");
    row.add("y");
    row.add("z");
    rows.add(row);

    for (var el in userAccelData.entries) {
      List<dynamic> row = [];
      row.add(el.key);
      row.add(el.value[0]);
      row.add(el.value[1]);
      row.add(el.value[2]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(
        rows,
      fieldDelimiter: ',',
      eol: '\n',
    );
    print(rows);
    print(csv);

    Directory? directory;
    directory = Directory('/storage/emulated/0/Download');
    // directory = await getDownloadsDirectory();
    if (!await directory.exists())
      directory = await getExternalStorageDirectory();

    String file = directory!.path;
    // print(directory);

    File f = File(file + "/userAccelData.csv");

    f.writeAsString(csv);
  }

  void generatePlot() {
    List<_SensorsData> xData = [];
    List<_SensorsData> yData = [];
    List<_SensorsData> zData = [];
    for (var elem in userAccelData.entries) {
      xData.add(_SensorsData(elem.key, elem.value[0]));
      yData.add(_SensorsData(elem.key, elem.value[1]));
      zData.add(_SensorsData(elem.key, elem.value[2]));
    }

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: 'Юзверь Аксель XYZ'),
                    legend: const Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_SensorsData, String>>[
                      LineSeries<_SensorsData, String>(
                        name: 'x',
                        dataSource: xData,
                        xValueMapper: (_SensorsData data, _) => data.time,
                        yValueMapper: (_SensorsData data, _) => data.coordinate,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                      LineSeries<_SensorsData, String>(
                        name: 'y',
                        dataSource: yData,
                        xValueMapper: (_SensorsData data, _) => data.time,
                        yValueMapper: (_SensorsData data, _) => data.coordinate,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                      LineSeries<_SensorsData, String>(
                        name: 'z',
                        dataSource: zData,
                        xValueMapper: (_SensorsData data, _) => data.time,
                        yValueMapper: (_SensorsData data, _) => data.coordinate,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Юзверь Аксель x'),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_SensorsData, String>>[
                        LineSeries<_SensorsData, String>(
                          name: 'x',
                          dataSource: xData,
                          xValueMapper: (_SensorsData data, _) => data.time,
                          yValueMapper: (_SensorsData data, _) => data.coordinate,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                  ),
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Юзверь Аксель y'),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_SensorsData, String>>[
                        LineSeries<_SensorsData, String>(
                          name: 'y',
                          dataSource: yData,
                          xValueMapper: (_SensorsData data, _) => data.time,
                          yValueMapper: (_SensorsData data, _) => data.coordinate,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                  ),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: 'Юзверь Аксель z'),
                    legend: const Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_SensorsData, String>>[
                      LineSeries<_SensorsData, String>(
                        name: 'z',
                        dataSource: zData,
                        xValueMapper: (_SensorsData data, _) => data.time,
                        yValueMapper: (_SensorsData data, _) => data.coordinate,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Accel demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...?_userAccelerometerValues?.map((e) => ListTile(
            title: Text(e.toString()),
          )),
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
          ElevatedButton(
            onPressed: generatePlot,
            child: Text("generate plot mem"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}

class _SensorsData {
  String time;
  double coordinate;

  _SensorsData(this.time, this.coordinate);
}
