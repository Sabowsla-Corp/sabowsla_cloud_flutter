import 'dart:convert';
import 'dart:developer';

import 'package:sabowsla_core_platform_interface/sabowsla_core_platform_interface.dart';

import '../constants.dart';

class SabowslaApp {
  final SabowslaOptions options;
  final String token;

  SabowslaApp(
    this.token, {
    required this.options,
  });

  static SabowslaApp? fromJson(Map<String, dynamic> json) {
    try {
      return SabowslaApp(
        json['token'] as String,
        options:
            SabowslaOptions.fromMap(json['options'] as Map<String, dynamic>),
      );
    } catch (e) {
      log("[sabowsla_core] SabowslaApp.fromJson error: $e");
      return null;
    }
  }

  static SabowslaApp? fromApiResponse(
      Map<String, dynamic> json, SabowslaOptions options,
      [String cloudEnpoint = sabowslaCloudApiUrl]) {
    try {
      return SabowslaApp(
        json['token'] as String,
        options: options,
      );
    } catch (e) {
      log("[sabowsla_core] SabowslaApp.fromApiResponse error: $e");
      return null;
    }
  }

  static SabowslaApp? fromJsonString(String json) {
    try {
      return SabowslaApp.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      log("[sabowsla_core] SabowslaApp.fromJsonString error: $e");
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'options': options.toMap(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  //Token and appOptions are required to make requests to the Sabowsla API.
  Map<String, String> getHeaders() {
    return {
      'bearer': token,
      'app-id': options.appId ?? "",
      'api-key': options.apiKey ?? "",
      'project-id': options.projectId ?? "",
    };
  }
}
