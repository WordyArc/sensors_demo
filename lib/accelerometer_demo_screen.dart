import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

@RoutePage()
class AccelerometerDemoScreen extends StatefulWidget {
  const AccelerometerDemoScreen({super.key});

  @override
  State<AccelerometerDemoScreen> createState() => _AccelerometerDemoScreenState();
}

class _AccelerometerDemoScreenState extends State<AccelerometerDemoScreen> {

  void accel() {
    final AccelerometerEvent accelerometerEvent = AccelerometerEvent(0, 0, 0);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accel demo'),
      ),
      body: Container(

      ),
    );
  }
}
