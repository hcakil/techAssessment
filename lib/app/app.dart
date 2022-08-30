
import 'package:etiyatechassessment/features/accounts/cubits/accountsCubit.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'package:hive_flutter/hive_flutter.dart';

import '../features/accounts/accountsRepository.dart';

import '../utils/constants.dart';
import '../utils/uiUtils.dart';
import 'appLocalization.dart';
import 'app_router.dart';

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));
  }
  await Hive.initFlutter();
  await Hive.openBox(
      authBox);




  return MyApp();
}



class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(UiUtils.getImagePath("splash_logo.png")), context);
    precacheImage(AssetImage(UiUtils.getImagePath("map_finded.png")), context);
    precacheImage(AssetImage(UiUtils.getImagePath("map_finding.png")), context);
    precacheImage(
        AssetImage(UiUtils.getImagePath("scratchCardCover.png")), context);

    return MultiBlocProvider(
      //providing global providers
      providers: [
   //For possible future implementations used MultiBlocProvider
        BlocProvider<AccountsCubit>(create: (_) => AccountsCubit(AccountsRepository(),[])),
      ],
      child: Builder(
        builder: (context) {

          return MaterialApp(
       debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: supportedLocales.map((languageCode) {
              return UiUtils.getLocaleFromLanguageCode(languageCode);
            }).toList(),
            home: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
            ),
          );
        },
      ),
    );
  }
}
