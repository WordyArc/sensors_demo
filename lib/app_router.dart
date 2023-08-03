import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:sensors_demo/qr_demo_screen.dart';
import 'package:sensors_demo/sensors_plus_example_screen.dart';
import 'package:sensors_demo/wifi_demo_screen.dart';
import 'package:sensors_demo/wifi_scan_demo_screen.dart';

import 'accelerometer_demo_screen.dart';
import 'is_lock_screen.dart';
import 'magnetometer_demo_screen.dart';
import 'mobile_scan_screen.dart';
import 'user_accelerometer_demo_screen.dart';
import 'ble_demo_screen.dart';
import 'ble_example_screen.dart';
import 'gyroscope_demo_screen.dart';
import 'main_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: MainRoute.page),
        AutoRoute(page: GyroscopeDemoRoute.page),
        AutoRoute(page: SensorsPlusDemoRoute.page),
        AutoRoute(page: BleExampleRoute.page),
        AutoRoute(page: BleDemoRoute.page),
        AutoRoute(page: AccelerometerDemoRoute.page),
        AutoRoute(page: UserAccelerometerDemoRoute.page),
        AutoRoute(page: MagnetometerDemoRoute.page),
        AutoRoute(page: WifiDemoRoute.page),
        AutoRoute(page: WifiScanDemoRoute.page),
        AutoRoute(page: IsLockRoute.page),
        AutoRoute(page: QrDemoRoute.page),
        AutoRoute(page: MobileScanRoute.page),
      ];
}
