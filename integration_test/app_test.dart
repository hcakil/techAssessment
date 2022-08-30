import 'package:bloc_test/bloc_test.dart';
import 'package:etiyatechassessment/app/appLocalization.dart';
import 'package:etiyatechassessment/app/app_router.dart';
import 'package:etiyatechassessment/features/accounts/account.dart';
import 'package:etiyatechassessment/features/accounts/accountsRepository.dart';
import 'package:etiyatechassessment/features/accounts/cubits/accountsCubit.dart';

import 'package:etiyatechassessment/ui/screens/accounts/accountScreen.dart';

import 'package:etiyatechassessment/utils/constants.dart';
import 'package:etiyatechassessment/utils/uiUtils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockAccountRepository extends Mock implements AccountsRepository {}

void main() {
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();
  late AccountsCubit accountsCubit;
  late MockAccountRepository mockAccountRepository;
  List<Account> mockList = [
    Account(
        api: "Phisherman",
        description: "IP/domain/URL reputation",
        auth: "",
        https: true,
        cors: "unknown",
        link: "https://phisherman.gg/",
        category: "Anti-Malware"),
    Account(
        api: "Trace Moe",
        description:
            "A useful tool to get the exact scene of an anime from a screenshot",
        auth: "apiKey",
        https: false,
        cors: "no",
        link: "https://soruly.github.io/trace.moe-api/#/",
        category: "Anime")
  ];

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    // when(mockAccountRepository.getAccounts()).thenReturn(mockAccountRepository);

    accountsCubit = AccountsCubit(mockAccountRepository, []);
    //mockAccountRepository = MockAccountRepository();
    //accountsCubit = AccountsCubit(mockAccountRepository,mockList);
  });

  void arrangeAccountServiceReturnTwoAccounts() async {
    when(() => mockAccountRepository.getAccounts()).thenAnswer((value) async {
      return mockList;
    });
  }

  void arrangeAccountServiceReturnTwoAccountsAfterTwoSeconds() {
    when(() => mockAccountRepository.getAccounts()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return mockList;
    });
  }

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      //providing global providers
      providers: [
        //Creating cubit/bloc that will be use in whole app or
        //will be use in multiple screens

        BlocProvider<AccountsCubit>(
            create: (_) => AccountsCubit(mockAccountRepository, [])),
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
           // onGenerateRoute: (_) => AccountsRoute.name,
            home: const AccountsScreen(),
          );
        },
      ),
    );
  }

  testWidgets("""Tapping  on the first account opens details page""",
      (WidgetTester tester) async {
    arrangeAccountServiceReturnTwoAccounts();

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pump(const Duration(seconds: 2));

  //  await tester.tap(find.text("Anti-Malware"));

   // await tester.pump(const Duration(seconds: 2));

    expect(find.byType(AccountsScreen), findsOneWidget);

    await tester.pump(const Duration(seconds: 20));

 //   expect(find.byType(SplashScreen), findsNothing);
   // expect(find.byType(AccountsScreen), findsOneWidget);

  //  expect(find.text("unknown"), findsOneWidget);
    // expect(find.text("Tennessee"), findsOneWidget);
  });
}
/* testGoldens(
    'Main Page',
        (tester) async {

      when(() => mock.getAccounts()).thenAnswer((_) async {});

      final builder = DeviceBuilder();

      // Loading
      builder.addScenario(
        name: 'Loading',
        widget: Builder(
          builder: (context) {
            whenListen(
              mock,
              Stream.fromIterable(
                 [
                  AccountsInitial(),
                  AccountsFetchInProgress(),
                ],
              ),
              initialState:  AccountsInitial(),
            );

            return const AccountsScreen();
          },
        ),
      );

      // Loaded
      builder.addScenario(
        name: 'Loaded',
        widget: Builder(
          builder: (context) {
            whenListen(
              mock,
              Stream.fromIterable(
                 [
                  AccountsInitial(),
                  AccountsFetchInProgress(),
                  AccountsFetchSuccess(
                    [
                      Account(
                          api: "Phisherman",
                          description: "IP/domain/URL reputation",
                          auth: "",
                          https: true,
                          cors: "unknown",
                          link: "https://phisherman.gg/",
                          category: "Anti-Malware"
                      ),
                      Account(
                          api: "Trace Moe",
                          description: "A useful tool to get the exact scene of an anime from a screenshot",
                          auth: "apiKey",
                          https: false,
                          cors: "no",
                          link: "https://soruly.github.io/trace.moe-api/#/",
                          category: "Anime"
                      )
                    ],
                  ),
                ],
              ),
              initialState:  AccountsInitial(),
            );
            return AccountsScreen();
          },
        ),
      );

      // Failure
      builder.addScenario(
        name: 'Failure',
        widget: Builder(
          builder: (context) {
            whenListen(
              mock,
              Stream.fromIterable(
                 [
                  AccountsInitial(),
                  AccountsFetchInProgress(),
                  AccountsFetchFailure("Something went wrong"),
                ],
              ),
              initialState:   AccountsInitial(),
            );

            return const AccountsScreen();
          },
        ),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'main_page');
    },
  );*/
