// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    IsLockRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IsLockScreen(),
      );
    },
    UserAccelerometerDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserAccelerometerDemoScreen(),
      );
    },
    SensorsPlusDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SensorsPlusDemoScreen(),
      );
    },
    WifiDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WifiDemoScreen(),
      );
    },
    QrDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const QrDemoScreen(),
      );
    },
    MobileScanRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MobileScanScreen(),
      );
    },
    BleExampleRoute.name: (routeData) {
      final args = routeData.argsAs<BleExampleRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BleExampleScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    BleDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BleDemoScreen(),
      );
    },
    AccelerometerDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccelerometerDemoScreen(),
      );
    },
    WifiScanDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WifiScanDemoScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    MagnetometerDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MagnetometerDemoScreen(),
      );
    },
    GyroscopeDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GyroscopeDemoScreen(),
      );
    },
  };
}

/// generated route for
/// [IsLockScreen]
class IsLockRoute extends PageRouteInfo<void> {
  const IsLockRoute({List<PageRouteInfo>? children})
      : super(
          IsLockRoute.name,
          initialChildren: children,
        );

  static const String name = 'IsLockRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserAccelerometerDemoScreen]
class UserAccelerometerDemoRoute extends PageRouteInfo<void> {
  const UserAccelerometerDemoRoute({List<PageRouteInfo>? children})
      : super(
          UserAccelerometerDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAccelerometerDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SensorsPlusDemoScreen]
class SensorsPlusDemoRoute extends PageRouteInfo<void> {
  const SensorsPlusDemoRoute({List<PageRouteInfo>? children})
      : super(
          SensorsPlusDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'SensorsPlusDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WifiDemoScreen]
class WifiDemoRoute extends PageRouteInfo<void> {
  const WifiDemoRoute({List<PageRouteInfo>? children})
      : super(
          WifiDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'WifiDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QrDemoScreen]
class QrDemoRoute extends PageRouteInfo<void> {
  const QrDemoRoute({List<PageRouteInfo>? children})
      : super(
          QrDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MobileScanScreen]
class MobileScanRoute extends PageRouteInfo<void> {
  const MobileScanRoute({List<PageRouteInfo>? children})
      : super(
          MobileScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'MobileScanRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BleExampleScreen]
class BleExampleRoute extends PageRouteInfo<BleExampleRouteArgs> {
  BleExampleRoute({
    Key? key,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          BleExampleRoute.name,
          args: BleExampleRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'BleExampleRoute';

  static const PageInfo<BleExampleRouteArgs> page =
      PageInfo<BleExampleRouteArgs>(name);
}

class BleExampleRouteArgs {
  const BleExampleRouteArgs({
    this.key,
    required this.title,
  });

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'BleExampleRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [BleDemoScreen]
class BleDemoRoute extends PageRouteInfo<void> {
  const BleDemoRoute({List<PageRouteInfo>? children})
      : super(
          BleDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'BleDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AccelerometerDemoScreen]
class AccelerometerDemoRoute extends PageRouteInfo<void> {
  const AccelerometerDemoRoute({List<PageRouteInfo>? children})
      : super(
          AccelerometerDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccelerometerDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WifiScanDemoScreen]
class WifiScanDemoRoute extends PageRouteInfo<void> {
  const WifiScanDemoRoute({List<PageRouteInfo>? children})
      : super(
          WifiScanDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'WifiScanDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MagnetometerDemoScreen]
class MagnetometerDemoRoute extends PageRouteInfo<void> {
  const MagnetometerDemoRoute({List<PageRouteInfo>? children})
      : super(
          MagnetometerDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'MagnetometerDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GyroscopeDemoScreen]
class GyroscopeDemoRoute extends PageRouteInfo<void> {
  const GyroscopeDemoRoute({List<PageRouteInfo>? children})
      : super(
          GyroscopeDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'GyroscopeDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
