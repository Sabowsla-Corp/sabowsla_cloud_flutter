import 'package:sabowsla_auth/src/user.dart';
import 'package:sabowsla_auth/src/user_credential.dart';

class EmailAuthProvider {
  static UserCredential credential({
    required String email,
    required String password,
  }) {
    return UserCredential(
      user: User(
        (b) => b
          ..email = email
          ..password = password,
      ),
      jwtToken: '',
    );
  }
}
