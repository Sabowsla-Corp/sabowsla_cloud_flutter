import 'package:sabowsla_auth/sabowsla_auth.dart';

class UserCredential {
  final User? user;
  final String? jwtToken;

  UserCredential({
    required this.user,
    required this.jwtToken,
  });

  static UserCredential fromJson(Map? body) {
    return UserCredential(
      user: User.fromMap(body?['user']),
      jwtToken: body?['jwtToken'],
    );
  }

  static UserCredential fromMap(Map body) => fromJson(body);

  Map<String, dynamic> toJson({
    required String jwtToken,
  }) =>
      toMap(
        jwtToken: jwtToken,
      );

  Map<String, dynamic> toMap({
    required String? jwtToken,
  }) {
    return {
      'user': user?.toJson(),
      'jwtToken': jwtToken,
    };
  }
}
