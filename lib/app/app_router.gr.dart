// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SplashScreen());
    },
    AccountsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: AccountsScreen());
    },
    AccountDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AccountDetailRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: AccountDetailScreen(key: args.key, data: args.data));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(AccountsRoute.name, path: '/accounts'),
        RouteConfig(AccountDetailRoute.name, path: '/accountDetail')
      ];
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [AccountsScreen]
class AccountsRoute extends PageRouteInfo<void> {
  const AccountsRoute() : super(AccountsRoute.name, path: '/accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for
/// [AccountDetailScreen]
class AccountDetailRoute extends PageRouteInfo<AccountDetailRouteArgs> {
  AccountDetailRoute({Key? key, required Account? data})
      : super(AccountDetailRoute.name,
            path: '/accountDetail',
            args: AccountDetailRouteArgs(key: key, data: data));

  static const String name = 'AccountDetailRoute';
}

class AccountDetailRouteArgs {
  const AccountDetailRouteArgs({this.key, required this.data});

  final Key? key;

  final Account? data;

  @override
  String toString() {
    return 'AccountDetailRouteArgs{key: $key, data: $data}';
  }
}
