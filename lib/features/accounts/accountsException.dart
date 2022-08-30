class AccountsException implements Exception {
  final String errorMessageCode;

  AccountsException({required this.errorMessageCode});

  @override
  String toString() => errorMessageCode;
}
