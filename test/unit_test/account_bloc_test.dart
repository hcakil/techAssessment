import 'dart:io';

import 'package:etiyatechassessment/features/accounts/account.dart';
import 'package:etiyatechassessment/features/accounts/accountsRepository.dart';
import 'package:etiyatechassessment/features/accounts/cubits/accountsCubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../constants/config.dart';



class MockAccountRepository extends Mock implements AccountsRepository {}

void main() {
  late AccountsCubit sut;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = AccountsCubit(mockAccountRepository,[]);
  });

  test("initial values are correct", () {
    expect(sut.accountsList, []);
   // expect(sut.accountSearchList, null);
  //  expect(sut.stateFilterList, null);
  //  expect(sut.stateFilterElement, "");

   // expect(sut.isList, true);
  });

  group("getAccounts", () {

    List<Account> mockList = [
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
    ];
    //function which returns 2 account added list
    void arrangeNewsServiceReturnTwoAccounts() {
      when(() => mockAccountRepository.getAccounts())
          .thenAnswer((_) async => mockList);
    }

    test("getAccounts using AccountService", () async {
      when(() => mockAccountRepository.getAccounts())
          .thenAnswer((_) async => mockList);

      await sut.getAccounts();
      verify(() => mockAccountRepository.getAccounts()).called(1);
    });

    test("""indicates loading of data,
         sets accounts which comes from the service,
         indicates that data is not being loaded anymore""", () async {
      arrangeNewsServiceReturnTwoAccounts();

      final future = sut.getAccounts();
      expect(sut.accountsList, []);
      await future;
      expect(sut.accountsList.length, 2);

    });
  });
}
