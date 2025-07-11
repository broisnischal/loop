import 'package:auto_route/auto_route.dart';
import 'package:loop/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomePageRoute.page, initial: true),
        AutoRoute(page: PaymentRoute.page),
        AutoRoute(page: EsewaPaymentRoute.page),
        AutoRoute(page: EsewaPaymentRoute.page, path: '/deeplink/esewa'),
      ];
}
