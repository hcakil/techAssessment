import 'dart:developer';

import 'package:etiyatechassessment/features/accounts/account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../accountsRepository.dart';

abstract class AccountsState {}

class AccountsInitial extends AccountsState {}

class AccountsFetchInProgress extends AccountsState {}

class AccountsFetchSuccess extends AccountsState {
  final List<Account> accounts;

  AccountsFetchSuccess(this.accounts);
}

class AccountsFetchFailure extends AccountsState {
  final String errorMessage;

  AccountsFetchFailure(this.errorMessage);
}

class AccountsCubit extends Cubit<AccountsState> {
  final AccountsRepository accountsRepository;
  late List<Account> accountsList;
  late List<Account> accountSearchList;
  late List<String> stateFilterList;
  late String stateFilterElement;
  late bool isList;

  AccountsCubit(this.accountsRepository, this.accountsList)
      : super(AccountsInitial());

  void updateState(AccountsState updatedState) {
    emit(updatedState);
  }

  Future<List<Account>?> getAccounts() async {
    if (kDebugMode) {
      print(" getAccounts accounts cubit");
    }
    emit(AccountsFetchInProgress());
    accountsRepository.getAccounts().then((value) {
      if (kDebugMode) {
        print(" getAccounts accounts cubit success");
      }

      if (kDebugMode) {
        print("${value.length}length on cubit success");
      }
      //fill their first values
      accountsList = value;
      accountSearchList = value;
      stateFilterList = ["All"];
      isList = true;

      //now get their api attributes
      for (var account in accountSearchList) {
        bool isThereAlready = false;
        for (int i = 0; i < stateFilterList.length; i++) {
          String filter = account.category;
          if (stateFilterList[i].contains(filter)) {
            isThereAlready = true;
            break;
          }
        }
        if (!isThereAlready) {
          stateFilterList.add(account.category);
        }
      }
      if (stateFilterList.isNotEmpty) {
        stateFilterElement = stateFilterList[0];
      }

      //Change status to fetch success
      emit(AccountsFetchSuccess(value));

      return accountSearchList;
    }).catchError((e) {
      emit(AccountsFetchFailure(e.toString()));

    });
    return null;
  }

  List<Account> getAllAccounts() {
    if (state is AccountsFetchSuccess) {
      return (state as AccountsFetchSuccess).accounts;
    }
    return [];
  }

  //update only type of UI elements
  void updateType(bool typeChange) {
    //
    if (state is AccountsFetchSuccess) {
      isList = typeChange;

      emit((AccountsFetchSuccess(accountSearchList)));
    }
  }
  //update only type of UI elements
  void filterAccounts(String searchText) {
    //
    if (state is AccountsFetchSuccess) {
      accountSearchList = [];

      accountsList.forEach((element) {
        if ((element.description.toLowerCase().contains(searchText.toLowerCase())) ||
            (element.description
                .toLowerCase()
                .contains(searchText.toLowerCase()))) {
          accountSearchList.add(element);
        }
      });
      log(accountSearchList.length.toString());
      emit((AccountsFetchSuccess(accountSearchList)));
    }
  }

  Future filterAccountsBasedOnApi(String apiAttribute) async {

    log(" filterAccountsBasedOnState worked");
    emit((AccountsFetchInProgress()));
    stateFilterElement = apiAttribute;
    accountSearchList = [];
    if (!apiAttribute.contains("All")) {
      for (var element in accountsList) {
        String filterString =
            element.category;
        if (filterString
            .toLowerCase()
            .contains(apiAttribute.toLowerCase())) {
          accountSearchList.add(element);
        }
      }
    } else {
      //Fill whole list
      accountSearchList = accountsList;
    }

    emit((AccountsFetchSuccess(accountSearchList)));
  }

}
