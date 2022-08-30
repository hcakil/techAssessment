import 'dart:ui';

const String appName = "Etiya Tech Assessment";
const String packageName = "com.digitalpratix.etiyatechassessment";

//supported language codes
//Add language code in this list
//visit this to find languageCode for your respective language
//https://developers.google.com/admin-sdk/directory/v1/languages
final List<String> supportedLocales = ['en', 'tr'];
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const selectedDrawerItemColor = Color(0xFFF1F5F8);
const selectedDrawerViewColor = Color(0xFFF1F5F8);
const bgColor = Color(0xFF212332);
//
const String defaultLanguageCode = 'en';

//Enter 2 Letter ISO Code of country
//It will be use for phone auth.
const String initialSelectedCountryCode = 'TR';

//Hive all boxes name
const String authBox = "auth";

//settings box keys
const String languageCodeKey = "language";

const String settingsThemeKey = "theme";

//Database related constants
//Add your database url

const String databaseUrl = "https://api.publicapis.org";
const String baseUrl = '$databaseUrl/entries';
const defaultPadding = 18.0;

const String getSupportedQuestionLanguageUrl = "${baseUrl}get_languages";

//other constants
const String defaultQuestionLanguageId = "1";
