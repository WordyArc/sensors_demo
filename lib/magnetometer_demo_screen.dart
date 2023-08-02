import 'dart:async';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class MagnetometerDemoScreen extends StatefulWidget {
  const MagnetometerDemoScreen({super.key});

  @override
  State<MagnetometerDemoScreen> createState() => _MagnetometerDemoScreenState();
}

class _MagnetometerDemoScreenState extends State<MagnetometerDemoScreen> {
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Map<String, List<double>> magnetometerData = {
    '00:00': [0, 0, 0]
  };

  void sensorsSubscribe() {
    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
            magnetometerData[DateTime.now().toString()] =
                _magnetometerValues!;
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

  void sensorsDispose() {
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
                  ...magnetometerData.entries.map((el) => ListTile(
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

    for (var el in magnetometerData.entries) {
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

    File f = File(file + "/magnetometerData.csv");

    f.writeAsString(csv);
  }

  void generatePlot() {
    List<_SensorsData> xData = [];
    List<_SensorsData> yData = [];
    List<_SensorsData> zData = [];
    for (var elem in magnetometerData.entries) {
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
                    title: ChartTitle(text: 'Магнетометр XYZ'),
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
                    title: ChartTitle(text: 'Магнетометр x'),
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
                    title: ChartTitle(text: 'Магнетометр y'),
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
                    title: ChartTitle(text: 'Магнетометр z'),
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
        title: Text('Магнетометр demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...?_magnetometerValues?.map((e) => ListTile(
                title: Text(e.toString()),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: sensorsSubscribe,
                child: const Text("Subscribe"),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: sensorsDispose,
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
            child: Text("save to file"),
          ),
          ElevatedButton(
            onPressed: generatePlot,
            child: Text("generate plot"),
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
