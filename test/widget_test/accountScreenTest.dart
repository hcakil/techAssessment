import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:etiyatechassessment/app/appLocalization.dart';
import 'package:etiyatechassessment/app/app_router.dart';
import 'package:etiyatechassessment/features/accounts/account.dart';
import 'package:etiyatechassessment/features/accounts/accountsRepository.dart';
import 'package:etiyatechassessment/features/accounts/cubits/accountsCubit.dart';
import 'package:etiyatechassessment/ui/screens/accounts/accountScreen.dart';
import 'package:etiyatechassessment/ui/widgets/circularProgressContainner.dart';
import 'package:etiyatechassessment/utils/constants.dart';
import 'package:etiyatechassessment/utils/uiUtils.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import '../constants/config.dart';

class MockAccountRepository extends Mock implements AccountsRepository {}

void main() {
  late AccountsCubit sut;
  late MockAccountRepository mockAccountRepository;
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = AccountsCubit(mockAccountRepository, []);
  });

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

  void arrangeAccountServiceReturnTwoAccounts() {
    when(() => mockAccountRepository.getAccounts()).thenAnswer((_) async {
      return mockList;
    });
  }

  void arrangeAccountServiceReturnTwoAccountsAfterTwoSeconds() {
    when(() => mockAccountRepository.getAccounts()).thenAnswer((_) async {
      await Future.delayed(Duration(seconds: 2));
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
            home: const AccountsScreen(),
          );
        },
      ),
    );
  }

  testWidgets("app bar displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturnTwoAccounts();
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text("Mobile Tech"), findsOneWidget);
  });

  testWidgets("loading indicator is displayed while waiting for accounts",
      (WidgetTester tester) async {
    arrangeAccountServiceReturnTwoAccountsAfterTwoSeconds();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CircularProgressContainer), findsOneWidget);
    //Settle until finish
    await tester.pump(const Duration(milliseconds: 5000));
  });

  //Bu bölüme bakılacak
 /* testWidgets("accounts are displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturnTwoAccounts();
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 1500));
    for (final account in mockList) {
      expect(find.text(account.category), findsOneWidget);
      expect(find.text(account.description), findsOneWidget);
    }
  });*/


}
