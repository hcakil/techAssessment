
import 'dart:convert';

import 'package:etiyatechassessment/features/accounts/account.dart';
import 'package:flutter/foundation.dart';

import 'accountsException.dart';
import 'accountsRemoteDataSource.dart';

class AccountsRepository {
  static final AccountsRepository _accountsRepository = AccountsRepository._internal();
  late AccountsRemoteDataSource _accountsRemoteDataSource;

  factory AccountsRepository() {
    _accountsRepository._accountsRemoteDataSource = AccountsRemoteDataSource();
    return _accountsRepository;
  }

  AccountsRepository._internal();

   getAccounts() async {
    try {
      List<Account> accounts = [];
      final accountsResult = await _accountsRemoteDataSource.getAccounts();
      if (kDebugMode) {
        print("repo get accounts started");
      }

      //get accounts
      if(accountsResult.statusCode! < 400 && accountsResult.statusCode! >=200)
        {
          if (kDebugMode) {
            print("repo get accounts 200 - 400 e geldi");
          }
          var accountData = accountsResult.data;
          //var jsonResponse = json.decode(accountsResult.data);
          accounts =   (accountData['entries'] as List).map((p)=>Account.fromJson(p)).toList();
         /* print(jsonResponse.toString());
          jsonResponse.forEach((v) {
            if (kDebugMode) {
              print("account$v");
            }
            accounts.add(Account.fromJson(v));
          });*/
        }
      if (kDebugMode) {
        print("${accounts.length}length");
      }
      List<Account> accountSub1 = accounts.sublist(1,2);
      List<Account> accountSub2 = accounts.sublist(28,29);
      List<Account> accountSub3 = accounts.sublist(46,47);
      List<Account> accountSub4 = accounts.sublist(61,62);

    List<Account> accountSub = [
      accountSub1.first,
      accountSub2.first,
      accountSub3.first,
      accountSub4.first,
    ];

      if (kDebugMode) {
        print("${accountSub.length}length sub");
      }

      return accountSub;
    } catch (e) {
      throw AccountsException(errorMessageCode: e.toString());
    }
  }


}
