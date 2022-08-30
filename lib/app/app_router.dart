// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../features/accounts/account.dart';

import '../ui/screens/accountDetails/accountDetailPage.dart';
import '../ui/screens/accounts/accountScreen.dart';
import '../ui/screens/splashScreen.dart';

part 'app_router.gr.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true,path: "/"),
    AutoRoute(page: AccountsScreen,path: "/accounts"),
    AutoRoute(page: AccountDetailScreen,path: "/accountDetail"),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter{

}