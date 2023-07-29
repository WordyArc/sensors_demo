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
    AccelerometerDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccelerometerDemoScreen(),
      );
    },
    GyroscopeDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GyroscopeDemoScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    SensorsPlusDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SensorsPlusDemoScreen(),
      );
    },
  };
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
