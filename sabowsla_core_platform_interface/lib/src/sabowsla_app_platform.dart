import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:sabowsla_core_platform_interface/constants.dart';
import 'package:sabowsla_core_platform_interface/sabowsla_core_platform_interface.dart';

var _instance = SabowslaAppPlatform();

class SabowslaAppPlatform {
  SabowslaAppPlatform({
    this.cloudEnpoint = sabowslaCloudApiUrl,
  });
  final String cloudEnpoint;

  static SabowslaAppPlatform get instance => _instance;

  Future<SabowslaApp?> initializeApp({
    required SabowslaOptions options,
  }) async {
    try {
      var uri = Uri.parse("$cloudEnpoint${SabowslaCloudRoutes.verifyAppRoute}");

      var res = await Client().post(
        uri,
        body: jsonEncode(options.toMap()),
      );
      var body = jsonDecode(res.body);
      var app = SabowslaApp.fromApiResponse(body, options, cloudEnpoint);

      return app;
    } catch (e) {
      log("[initialize] error: $e");
      rethrow;
    }
  }
}
