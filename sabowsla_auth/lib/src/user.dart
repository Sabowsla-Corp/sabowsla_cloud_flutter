import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sabowsla_auth/src/serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  User._();
  factory User([void Function(UserBuilder) updates]) = _$User;

  String get email;
  String get uid;
  String get photoUrl;
  String get displayName;
  String get password;
  String get creationDate;
  String get userName;
  String get lastLoginDate;

  static User? fromJson(String jsonString) {
    return serializers.deserializeWith(
        User.serializer, json.decode(jsonString));
  }

  String toRawJson() {
    return jsonEncode(serializers.serializeWith(User.serializer, this));
  }

  Map<String, dynamic> toJson() => serializers.serializeWith(
        User.serializer,
        this,
      ) as Map<String, dynamic>;

  static User? fromMap(Map? map) {
    if (map == null) return null;
    return serializers.deserializeWith(User.serializer, map);
  }

  static newUser({
    required String displayName,
    required String email,
    required String uid,
    DateTime? creationDate,
    required String photoBase64,
    required String passwordHash,
    required String userName,
    DateTime? lastLoginDate,
  }) {
    return User(
      (b) => b
        ..email = email
        ..uid = uid
        ..photoUrl = ''
        ..displayName = displayName
        ..password = passwordHash
        ..creationDate = creationDate?.toIso8601String()
        ..userName = userName
        ..lastLoginDate = lastLoginDate?.toIso8601String(),
    );
  }
}
