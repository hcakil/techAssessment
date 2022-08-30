import 'package:etiyatechassessment/features/accounts/account.dart';

class ConfigTest {
  final String responseBody = """{
 "count":30,
"entries":
[
{
         "API":"Trace Moe",
         "Description":"A useful tool to get the exact scene of an anime from a screenshot",
         "Auth":"",
         "HTTPS":true,
         "Cors":"no",
         "Link":"https://soruly.github.io/trace.moe-api/#/",
         "Category":"Anime"
      },
      {
         "API":"Phisherman",
         "Description":"IP/domain/URL reputation",
         "Auth":"apiKey",
         "HTTPS":true,
         "Cors":"unknown",
         "Link":"https://phisherman.gg/",
         "Category":"Anti-Malware"
      }
  ]
}""";

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
}
