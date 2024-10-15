import 'package:sabowsla_auth/sabowsla_auth.dart';
import 'package:sabowsla_auth/src/result.dart';

typedef LoginResultType = (LoginError?, UserCredential?);

class LoginResult extends Result {
  LoginResult({
    required this.data,
  });

  @override
  final LoginResultType data;

  LoginError? get error => data.$1;
  UserCredential? get userCredential => data.$2;

  Map<String, dynamic> toJson({required String token}) => toMap(token);

  @override
  Map<String, dynamic> toMap([String jwtToken = '']) => {
        'error': error?.name,
        'userCredential': userCredential?.toJson(jwtToken: jwtToken),
      };

  static LoginResult fromJson(Map<String, dynamic> json) {
    return LoginResult(
      data: (
        json['error'] != null ? LoginError.values.byName(json['error']) : null,
        UserCredential.fromJson(json['userCredential'])
      ),
    );
  }

  @override
  bool get isSuccess =>
      error == null &&
      userCredential != null &&
      userCredential?.jwtToken != null &&
      userCredential?.jwtToken != '';

  @override
  String toString() {
    return 'LoginResult(error: $error, userCredential: $userCredential)';
  }

  @override
  List<Object?> get props => [error, userCredential];

  @override
  Result fromMap(Map<String, dynamic> json) {
    return fromJson(json);
  }
}
