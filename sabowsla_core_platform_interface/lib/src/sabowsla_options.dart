const String defaultFirebaseAppName = 'Sabowsla App (Default)';

abstract class SabowslaOptions {
  final String? apiKey;
  final String? authDomain;
  final String? databaseURL;
  final String? projectId;
  final String? storageBucket;
  final String? messagingSenderId;
  final String? appId;
  final String? platform;

  SabowslaOptions({
    required this.apiKey,
    required this.authDomain,
    required this.databaseURL,
    required this.projectId,
    required this.storageBucket,
    required this.messagingSenderId,
    required this.appId,
    required this.platform,
  });

  Map<String, String> toMap() {
    return {
      'apiKey': apiKey ?? '',
      'authDomain': authDomain ?? '',
      'databaseURL': databaseURL ?? '',
      'projectId': projectId ?? '',
      'storageBucket': storageBucket ?? '',
      'messagingSenderId': messagingSenderId ?? '',
      'appId': appId ?? '',
      'platform': platform ?? '',
    };
  }

  static SabowslaOptions fromMap(Map<String, dynamic> map) {
    return BaseSabowslaAppOptions(
      apiKey: map['apiKey'] ?? '',
      authDomain: map['authDomain'] ?? '',
      databaseURL: map['databaseURL'] ?? '',
      projectId: map['projectId'] ?? '',
      storageBucket: map['storageBucket'] ?? '',
      messagingSenderId: map['messagingSenderId'] ?? '',
      appId: map['appId'] ?? '',
      platform: map['platform'] ?? '',
    );
  }
}

class BaseSabowslaAppOptions extends SabowslaOptions {
  BaseSabowslaAppOptions({
    super.apiKey = "",
    super.authDomain = "",
    super.databaseURL = "",
    super.projectId = "",
    super.storageBucket = "",
    super.messagingSenderId = "",
    super.appId = "",
    super.platform = "",
  });
  @override
  Map<String, String> toMap() {
    return {
      'apiKey': apiKey ?? '',
      'authDomain': authDomain ?? '',
      'databaseURL': databaseURL ?? '',
      'projectId': projectId ?? '',
      'storageBucket': storageBucket ?? '',
      'messagingSenderId': messagingSenderId ?? '',
      'appId': appId ?? '',
    };
  }
}
