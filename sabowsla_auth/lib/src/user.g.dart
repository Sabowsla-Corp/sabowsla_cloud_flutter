// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object?> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'photoUrl',
      serializers.serialize(object.photoUrl,
          specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'creationDate',
      serializers.serialize(object.creationDate,
          specifiedType: const FullType(String)),
      'userName',
      serializers.serialize(object.userName,
          specifiedType: const FullType(String)),
      'lastLoginDate',
      serializers.serialize(object.lastLoginDate,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'photoUrl':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'creationDate':
          result.creationDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userName':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'lastLoginDate':
          result.lastLoginDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final String email;
  @override
  final String uid;
  @override
  final String photoUrl;
  @override
  final String displayName;
  @override
  final String password;
  @override
  final String creationDate;
  @override
  final String userName;
  @override
  final String lastLoginDate;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates))._build();

  _$User._(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.displayName,
      required this.password,
      required this.creationDate,
      required this.userName,
      required this.lastLoginDate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'User', 'email');
    BuiltValueNullFieldError.checkNotNull(uid, r'User', 'uid');
    BuiltValueNullFieldError.checkNotNull(photoUrl, r'User', 'photoUrl');
    BuiltValueNullFieldError.checkNotNull(displayName, r'User', 'displayName');
    BuiltValueNullFieldError.checkNotNull(password, r'User', 'password');
    BuiltValueNullFieldError.checkNotNull(
        creationDate, r'User', 'creationDate');
    BuiltValueNullFieldError.checkNotNull(userName, r'User', 'userName');
    BuiltValueNullFieldError.checkNotNull(
        lastLoginDate, r'User', 'lastLoginDate');
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        email == other.email &&
        uid == other.uid &&
        photoUrl == other.photoUrl &&
        displayName == other.displayName &&
        password == other.password &&
        creationDate == other.creationDate &&
        userName == other.userName &&
        lastLoginDate == other.lastLoginDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, creationDate.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, lastLoginDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('email', email)
          ..add('uid', uid)
          ..add('photoUrl', photoUrl)
          ..add('displayName', displayName)
          ..add('password', password)
          ..add('creationDate', creationDate)
          ..add('userName', userName)
          ..add('lastLoginDate', lastLoginDate))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _creationDate;
  String? get creationDate => _$this._creationDate;
  set creationDate(String? creationDate) => _$this._creationDate = creationDate;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _lastLoginDate;
  String? get lastLoginDate => _$this._lastLoginDate;
  set lastLoginDate(String? lastLoginDate) =>
      _$this._lastLoginDate = lastLoginDate;

  UserBuilder();

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _uid = $v.uid;
      _photoUrl = $v.photoUrl;
      _displayName = $v.displayName;
      _password = $v.password;
      _creationDate = $v.creationDate;
      _userName = $v.userName;
      _lastLoginDate = $v.lastLoginDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    final _$result = _$v ??
        new _$User._(
            email:
                BuiltValueNullFieldError.checkNotNull(email, r'User', 'email'),
            uid: BuiltValueNullFieldError.checkNotNull(uid, r'User', 'uid'),
            photoUrl: BuiltValueNullFieldError.checkNotNull(
                photoUrl, r'User', 'photoUrl'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'User', 'displayName'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'User', 'password'),
            creationDate: BuiltValueNullFieldError.checkNotNull(
                creationDate, r'User', 'creationDate'),
            userName: BuiltValueNullFieldError.checkNotNull(
                userName, r'User', 'userName'),
            lastLoginDate: BuiltValueNullFieldError.checkNotNull(
                lastLoginDate, r'User', 'lastLoginDate'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
