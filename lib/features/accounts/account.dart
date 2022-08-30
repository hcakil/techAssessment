// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  Account({
    required  this.api,
    required  this.description,
    required  this.auth,
    required  this.https,
    required  this.cors,
    required  this.link,
    required  this.category,
  });

  String api;
  String description;
  String auth;
  bool https;
  String cors;
  String link;
  String category;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    api: json["API"],
    description: json["Description"],
    auth: json["Auth"],
    https: json["HTTPS"],
    cors: json["Cors"],
    link: json["Link"],
    category: json["Category"],
  );

  Map<String, dynamic> toJson() => {
    "API": api,
    "Description": description,
    "Auth": auth,
    "HTTPS": https,
    "Cors": cors,
    "Link": link,
    "Category": category,
  };
}
