import 'package:auto_route/auto_route.dart';

import 'gyroscope_demo_screen.dart';
import 'main_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainRoute.page,
          children: [
            AutoRoute(path: 'gyroscope', page: GyroscopeDemoRoute.page),
          ]
        ),
      ];
}
