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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).push(UserAccelerometerDemoRoute());
                  },
                  child: const Text("UserAccel demo"),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).push(AccelerometerDemoRoute());
                  },
                  child: const Text("Accel demo"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // AutoRouter.of(context).push(GyroscopeDemoRoute());
                    context.router.navigate(GyroscopeDemoRoute());
                  },
                  child: const Text("Gyro demo"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {
                  AutoRouter.of(context).push(MagnetometerDemoRoute());
                }, child: const Text("Magnetometer demo"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {
                      AutoRouter.of(context).navigate(
                        SensorsPlusDemoRoute(),
                      );
                    },
                    child: const Text("demo")),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {
                      AutoRouter.of(context)
                          .navigate(BleExampleRoute(title: 'anrey'));
                    },
                    child: const Text("ble example"),
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  AutoRouter.of(context).navigate(BleDemoRoute());
                },
                child: Text('ble demo')),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
