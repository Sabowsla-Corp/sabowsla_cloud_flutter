part of 'package:sabowsla_core/sabowsla_core.dart';

/// The entry point for accessing Sabowsla.
class Sabowsla {
  // Ensures end-users cannot initialize the class.
  Sabowsla._();

  // Cached & lazily loaded instance of [SabowslaPlatform].
  // Avoids a [MethodChannelSabowsla] being initialized until the user
  // starts using Sabowsla.
  // The property is visible for testing to allow tests to set a mock
  // instance directly as a static property since the class is not initialized.
  @visibleForTesting
  // ignore: public_member_api_docs
  static SabowslaAppPlatform? delegatePackingProperty;

  static SabowslaAppPlatform get _delegate {
    return delegatePackingProperty ??= SabowslaAppPlatform.instance;
  }

  static Future<SabowslaApp?> initializeApp({
    String? name,
    required SabowslaOptions options,
  }) async {
    return _delegate.initializeApp(options: options);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Sabowsla) return false;
    return other.hashCode == hashCode;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => toString().hashCode;

  @override
  String toString() => '$Sabowsla';
}
