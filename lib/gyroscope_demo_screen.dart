import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

@RoutePage()
class GyroscopeDemoScreen extends StatefulWidget {
  const GyroscopeDemoScreen({super.key});

  @override
  State<GyroscopeDemoScreen> createState() => _GyroscopeDemoScreenState();
}

class _GyroscopeDemoScreenState extends State<GyroscopeDemoScreen> {
  double dx = 100, dy = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gyroscope demo"),
      ),
      body: StreamBuilder<GyroscopeEvent>(
        stream: SensorsPlatform.instance.gyroscopeEvents,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            dx = dx + (snapshot.data!.y*10);
            dy = dy + (snapshot.data!.x*10);
          }
          return Transform.translate(
              offset: Offset(dx, dy),
              child: const CircleAvatar(radius: 20,)
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
