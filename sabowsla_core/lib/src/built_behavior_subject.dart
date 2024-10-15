part of 'package:sabowsla_core/sabowsla_core.dart';

/// A [BehaviorSubject] that persists its value to [Sembast]
/// type Serializable values must implement [BuiltValue] and must have a json serialization method
class BuiltBehaviorSubject<T> extends Subject<T> {
  BuiltBehaviorSubject._(
    super.controller,
    super.stream,
    this._wrapper,
    this.key,
    this.onValueLoaded,
  ) {
    loadDefaultValue();
  }

  final String key;
  final void Function(T value)? onValueLoaded;
  final _Wrapper<T> _wrapper;

  T get value {
    final value = _wrapper.value;
    if (isNotEmpty(value)) {
      return value as T;
    }
    throw ValueStreamError.hasNoValue();
  }

  void loadDefaultValue() async {
    if (_storage == null) {
      await Future.delayed(const Duration(seconds: 1));
      if (_storage == null) {
        return;
      }
    }
    final rawMap = await store.record(key).get(_coreDb!);
    var value = _wrapper.value as Serializable?;
    if (rawMap != null && value != null) {
      final mapValue = value.fromJson(rawMap);
      onValueLoaded?.call(mapValue as T);
    }
  }

  factory BuiltBehaviorSubject.seeded(
    T seedValue,
    String key, {
    void Function()? onListen,
    void Function()? onCancel,
    void Function(T value)? onValueLoaded,
    bool sync = false,
  }) {
    // ignore: close_sinks
    final controller = StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );

    final wrapper = _Wrapper<T>.seeded(seedValue);

    return BuiltBehaviorSubject<T>._(
      controller,
      Rx.defer<T>(_deferStream(wrapper, controller, sync), reusable: true),
      wrapper,
      key,
      onValueLoaded,
    );
  }

  static Stream<Serializable> Function() _deferStream<Serializable>(
    _Wrapper<Serializable> wrapper,
    StreamController<Serializable> controller,
    bool sync,
  ) =>
      () {
        final errorAndStackTrace = wrapper.errorAndStackTrace;
        if (errorAndStackTrace != null && !wrapper.isValue) {
          return controller.stream.transform(
            StartWithErrorStreamTransformer(
              errorAndStackTrace.error,
              errorAndStackTrace.stackTrace,
            ),
          );
        }

        final value = wrapper.value;
        if (isNotEmpty(value) && wrapper.isValue) {
          return controller.stream
              .transform(StartWithStreamTransformer(value as Serializable));
        }

        return controller.stream;
      };
}

Database? get _storage {
  if (_coreDb != null) {
    return _coreDb;
  }
  registerStorageFallback();
  return null;
}

var store = StoreRef.main();

void registerStorageFallback() async {
  final dir = await getApplicationCacheDirectory();
  await dir.create(recursive: true);
  final dbPath = '${dir.path}/sabowsla_core.db';
  _coreDb = await databaseFactoryIo.openDatabase(dbPath);
}

Database? _coreDb;
