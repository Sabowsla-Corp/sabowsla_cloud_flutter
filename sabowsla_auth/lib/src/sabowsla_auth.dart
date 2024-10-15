import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:sabowsla_auth/sabowsla_auth.dart';
import 'package:sabowsla_core/sabowsla_core.dart';
import 'package:sabowsla_core_platform_interface/constants.dart';
import 'package:sabowsla_core_platform_interface/sabowsla_core_platform_interface.dart';

enum ForgotPasswordResult { success, userNotFound, networkError, unknownError }

SabowslaAuth? _currentInstance;

class SabowslaAuth {
  static SabowslaAuth? overrideInstance;

  static SabowslaAuth get instance {
    if (overrideInstance != null) {
      return overrideInstance!;
    }
    if (_currentInstance == null) {
      throw UnimplementedError(
          "SabowslaAuth has not been initialized, call Sabowsla.initializeApp() first");
    }
    return _currentInstance!;
  }

  final BuiltBehaviorSubject<User?> userStream =
      BuiltBehaviorSubject<User?>.seeded(
    null,
    'userStream',
  );

  SabowslaAuth._({required this.sabowslaApp});

  static SabowslaAuth createInstance(SabowslaApp app) {
    var instance = SabowslaAuth._(sabowslaApp: app);
    _currentInstance = instance;
    log("SabowslaAuth initialized");
    return instance;
  }

  final SabowslaApp sabowslaApp;
  final Client _httpClient = Client();
  User? get currentUser => userStream.value;

  var url = sabowslaCloudApiUrl;

  String get singInUrl => url + AuthApiRoutes.login.route;
  String get singUpUrl => url + AuthApiRoutes.register.route;
  String get forgotPasswordUrl => url + AuthApiRoutes.forgotPassword.route;
  String get confirmPasswordResetUrl =>
      url + AuthApiRoutes.confirmPasswordReset.route;
  String get confirmEmailUrl => url + AuthApiRoutes.confirmEmail.route;
  String get getIdTokenUrl => url + AuthApiRoutes.getIdToken.route;

  Future<LoginResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var passwordHash = AuthCore.hashPassword(password);

      var response = await _httpClient.post(
        Uri.parse(singInUrl),
        headers: sabowslaApp.getHeaders(),
        body: jsonEncode({'email': email, 'passwordHash': passwordHash}),
      );

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      var jsonResponse = jsonDecode(response.body);
      return LoginResult.fromJson(jsonResponse);
    } catch (e) {
      log("SabowslaAuth [signInWithEmailAndPassword] error: $e");
      return LoginResult(data: (LoginError.unknown, null));
    }
  }

  //This methods throws an exception if the oobCode is invalid
  Future<void> verifyPasswordResetCode({required String code}) async {
    try {
      await _httpClient.post(
        Uri.parse("$sabowslaCloudApiUrl/auth/verifyPasswordResetCode"),
        headers: sabowslaApp.getHeaders(),
        body: {'oobCode': code},
      );
    } catch (e) {
      log("[verifyPasswordResetCode] error: $e");
      rethrow;
    }
  }

  Future<LoginResult> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var passwordHash = AuthCore.hashPassword(password);
      var response = await _httpClient.post(
        Uri.parse(
          sabowslaCloudApiUrl + AuthApiRoutes.register.route,
        ),
        headers: sabowslaApp.getHeaders(),
        body: jsonEncode({'email': email, 'passwordHash': passwordHash}),
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      LoginResult loginResult = LoginResult.fromJson(jsonDecode(response.body));
      return loginResult;
    } catch (e) {
      return LoginResult(data: (LoginError.unknown, null));
    }
  }

  Future<void> signOut() async {
    userStream.add(null);
  }

  Future<LoginResult> deleteUser({
    required String? email,
    required String? password,
  }) async {
    try {
      var passwordHash = AuthCore.hashPassword(password!);
      var response = await _httpClient.delete(
        Uri.parse(
          sabowslaCloudApiUrl + AuthApiRoutes.deleteUser.route,
        ),
        headers: sabowslaApp.getHeaders(),
        body: jsonEncode({'email': email, 'passwordHash': passwordHash}),
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      LoginResult loginResult = LoginResult.fromJson(jsonDecode(response.body));
      return loginResult;
    } catch (e) {
      log("[deleteUser] error: $e");
      return LoginResult(data: (LoginError.unknown, null));
    }
  }

  Future<String?> getIdToken() async {
    try {
      var response = await _httpClient.post(
        Uri.parse(getIdTokenUrl),
        headers: sabowslaApp.getHeaders(),
        body: {'x-user-id': currentUser?.uid},
      );
      log("[getIdToken] response: ${response.body}");
      return response.body;
    } catch (e) {
      log("[getIdToken] error: $e");
      return null;
    }
  }

  Future<ForgotPasswordResult> sendForgotPasswordEmail({
    required String email,
  }) async {
    try {
      await _httpClient.post(
        Uri.parse(forgotPasswordUrl),
        headers: sabowslaApp.getHeaders(),
        body: {'email': email},
      );
      return ForgotPasswordResult.success;
    } catch (e) {
      log("[sendForgotPasswordEmail] error: $e");
      return ForgotPasswordResult.unknownError;
    }
  }

  Future<bool> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    try {
      await _httpClient.post(
        Uri.parse(confirmPasswordResetUrl),
        headers: sabowslaApp.getHeaders(),
        body: {'oobCode': code, 'newPassword': newPassword},
      );
      return true;
    } catch (e) {
      log("[confirmPasswordReset] error: $e");
      return false;
    }
  }
}
