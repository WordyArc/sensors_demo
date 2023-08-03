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
        title: const Text("Artyom lol"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Card(
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const UserAccelerometerDemoRoute());
                },
                child: const ListTile(
                  title: Text('User Accel demo'),
                  leading: Icon(
                    Icons.sensor_occupied,
                    color: Colors.blue,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15,
                  ),

                ),
              ),
            ),
            Card(
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const AccelerometerDemoRoute());
                },
                child: const ListTile(
                  title: Text('Accel demo'),
                  leading: Icon(
                    Icons.edgesensor_high,
                    color: Colors.blue,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15,
                  ),

                ),
              ),
            ),
            Card(
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const GyroscopeDemoRoute());
                },
                child: const ListTile(
                  title: Text('Gyroscope demo'),
                  leading: Icon(
                    Icons.sensors,
                    color: Colors.blue,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15,
                  ),

                ),
              ),
            ),
            Card(
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const MagnetometerDemoRoute());
                },
                child: const ListTile(
                  title: Text('Magnetometer demo'),
                  leading: Icon(
                    Icons.sensor_door,
                    color: Colors.blue,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15,
                  ),

                ),
              ),
            ),
            const Spacer(),
            Card(
              color: Colors.amber,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const SensorsPlusDemoRoute());
                },
                child: const ListTile(
                  title: Text(
                    'Sensors demo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.sensor_door,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),
            Card(
              color: Colors.amber,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(BleExampleRoute(title: 'Andrey'));
                },
                child: const ListTile(
                  title: Text(
                    'Ble example',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.sensor_door,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),
            Card(
              color: Colors.amber,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const BleDemoRoute());
                },
                child: const ListTile(
                  title: Text(
                    'ble demo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.sensor_door,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),
            const Spacer(),
            Card(
              color: Colors.green,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const WifiDemoRoute());
                },
                child: const ListTile(
                  title: Text(
                    'Wifi demo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.wifi,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),
            Card(
              color: Colors.green,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const WifiScanDemoRoute());
                },
                child: const ListTile(
                  title: Text(
                    'Wifi Scan demo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.wifi,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),

            Spacer(),
            Card(
              color: Colors.blue,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const IsLockRoute());
                },
                child: const ListTile(
                  title: Text(
                    'isLockScreen demo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.screen_lock_portrait,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),
            Spacer(),

            Spacer(),
            Card(
              color: Colors.purpleAccent,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const QrDemoRoute());
                },
                child: const ListTile(
                  title: Text(
                    'Qr demo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.qr_code,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),
            Card(
              color: Colors.purpleAccent,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(const MobileScanRoute());
                },
                child: const ListTile(
                  title: Text(
                    'mobile scan demo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.qr_code,
                    color: Colors.white,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),

                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
