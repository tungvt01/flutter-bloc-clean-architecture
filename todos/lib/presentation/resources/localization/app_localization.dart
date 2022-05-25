import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  static AppLocalizations shared = AppLocalizations._();
  Map<dynamic, dynamic> _localisedValues = {};

  AppLocalizations._();

  static AppLocalizations of(BuildContext context) {
    return shared;
  }

  String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }

  // defined text
  String get appName => text('app_name');
  String get sessionExpiredMessage =>
      text('common_message_error_session_expired');
  String get commonMessageConnectionError =>
      text('common_message_connection_error');
  String get commonMessageServerMaintenance =>
      text('common_message_server_maintenance');
  String get commonMessageEmailError => text('common_message_email_error');
  String get commonMessageNoData => text('common_message_no_data');
  String get homeUtilityMessage => text('home_utility_message');
  

  /// common*/
  String get nextButton => text('next_button');

  Future<void> reloadLanguageBundle({required String languageCode}) async {
    String path = "assets/jsons/localization_$languageCode.json";
    String jsonContent = "";
    try {
      jsonContent = await rootBundle.loadString(path);
    } catch (_) {
      //use default Vietnamese
      jsonContent =
          await rootBundle.loadString("assets/jsons/localization_en.json");
    }
    _localisedValues = json.decode(jsonContent);
  }
}
