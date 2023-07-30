import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sensors_demo/app_router.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artyom lol"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            ElevatedButton(
                onPressed: () {
                // AutoRouter.of(context).push(GyroscopeDemoRoute());
                  context.router.navigate(GyroscopeDemoRoute());
            }, child: const Text("Gyro demo")),
            ElevatedButton(onPressed: () {}, child: const Text("Accel demo")),
            ElevatedButton(onPressed: () {}, child: const Text("Magnetometer demo")),
            ElevatedButton(onPressed: () {
              AutoRouter.of(context).navigate(SensorsPlusDemoRoute());
            }, child: const Text("demo")),
            ElevatedButton(onPressed: () {
              AutoRouter.of(context).navigate(BleExampleRoute(title: 'anrey'));
            }, child: const Text("ble example")),
            ElevatedButton(onPressed: () {
              AutoRouter.of(context).navigate(BleDemoRoute());
            }, child: Text('ble demo')),
            Spacer(),
          ],
        ),
      ),

    );
  }
}
