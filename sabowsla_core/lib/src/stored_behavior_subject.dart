part of 'package:sabowsla_core/sabowsla_core.dart';

SharedPreferences? _prefs;

class StoredBehaviorSubject<T> extends Subject<T> {
  StoredBehaviorSubject._(
    super.controller,
    super.stream,
    this._wrapper,
    this.key,
    this.valueToStorageObject,
    this.storageObjectToValue,
    this.onValueLoaded,
  ) {
    loadDefaultValue();
  }

  static StoredBehaviorSubject<int?> intSeeded(
    int? seedValue,
    String key, {
    void Function()? onListen,
    void Function()? onCancel,
    bool sync = false,
  }) {
    return StoredBehaviorSubject<int?>.seeded(
      seedValue,
      key,
      <T>(int? emitValue) => emitValue.toString(),
      (s) => int.tryParse(s ?? "0") ?? 0,
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );
  }

  static StoredBehaviorSubject<String?> stringSeeded(
    String? seedValue,
    String key, {
    void Function()? onListen,
    void Function()? onCancel,
    void Function(String value)? onValueLoaded,
    bool sync = false,
  }) {
    return StoredBehaviorSubject<String?>.seeded(
      seedValue,
      key,
      <T>(String? emitValue) {
        log("Value to Storage $emitValue");
        return emitValue;
      },
      (s) {
        log("Storage to Value $s");
        return s;
      },
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );
  }

  factory StoredBehaviorSubject.seeded(
    T seedValue,
    String key,
    Function<String>(T event) valueToStorageObject,
    T Function(String? savedEvent) storageObjectToValue, {
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

    return StoredBehaviorSubject<T>._(
      controller,
      Rx.defer<T>(_deferStream(wrapper, controller, sync), reusable: true),
      wrapper,
      key,
      valueToStorageObject,
      storageObjectToValue,
      onValueLoaded,
    );
  }

  final _Wrapper<T> _wrapper;
  final String key;
  //Transforms the event from the stream to a string to be saved in sharedprefs
  final Function<String>(T event) valueToStorageObject;
  //Transforms the string saved in sharedprefs to an event
  final T Function(String? savedEvent) storageObjectToValue;
  //Called when the value is loaded from sharedprefs
  final void Function(T value)? onValueLoaded;

  SharedPreferences? get _storage {
    if (_prefs != null) {
      return _prefs;
    }
    registerStorageFallback();
    return null;
  }

  void registerStorageFallback() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void onAdd(T event) {
    _wrapper.setValue(event);
    saveValue(event);
  }

  void saveValue(T event) async {
    var transformed = valueToStorageObject(event);
    while (_storage == null) {
      await Future.delayed(const Duration(seconds: 1));
    }
    await _storage?.setString(key, transformed);
  }

  @override
  void onAddError(Object error, [StackTrace? stackTrace]) {
    _wrapper.setError(error, stackTrace);
  }

  void onAddStream(Stream<T> stream, bool cancelOnError) {
    stream.listen(
      add,
      onError: addError,
      onDone: close,
    );
  }

  @override
  void add(T event) {
    saveValue(event);
    super.add(event);
  }

  void loadDefaultValue() async {
    if (_storage == null) {
      await Future.delayed(const Duration(seconds: 1));
      if (_storage == null) {
        return;
      }
    }
    final rawValue = _storage?.getString(key);
    if (rawValue != null) {
      final decodedValue = storageObjectToValue(rawValue);
      add(decodedValue);
      onValueLoaded?.call(decodedValue);
    }
  }

  T get value {
    final value = _wrapper.value;
    if (isNotEmpty(value)) {
      return value as T;
    }
    throw ValueStreamError.hasNoValue();
  }

  static Stream<T> Function() _deferStream<T>(
    _Wrapper<T> wrapper,
    StreamController<T> controller,
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
              .transform(StartWithStreamTransformer(value as T));
        }

        return controller.stream;
      };
}

class _Wrapper<T> {
  /// Non-seeded constructor
  _Wrapper() : isValue = false;

  _Wrapper.seeded(this.value) : isValue = true;
  bool isValue;
  var value = EMPTY;
  ErrorAndStackTrace? errorAndStackTrace;

  void setValue(T event) {
    value = event;
    isValue = true;
  }

  void setError(Object error, StackTrace? stackTrace) {
    errorAndStackTrace = ErrorAndStackTrace(error, stackTrace);
    isValue = false;
  }
}

class _Empty {
  const _Empty();

  @override
  String toString() => '<<EMPTY>>';
}

/// @internal
/// Sentinel object used to represent a missing value (distinct from `null`).
// ignore: unnecessary_nullable_for_final_variable_declarations
const Object? EMPTY = _Empty(); // ignore: constant_identifier_names

/// @internal
/// Returns `null` if [o] is [EMPTY], otherwise returns itself.
T? unbox<T>(Object? o) => identical(o, EMPTY) ? null : o as T;

/// @internal
/// Returns `true` if [o] is not [EMPTY].
bool isNotEmpty(Object? o) => !identical(o, EMPTY);

String textToNumberRepresentation(String text) {
  StringBuffer buffer = StringBuffer();

  for (int i = 0; i < text.length; i++) {
    buffer.write(
      text.codeUnitAt(i),
    ); // Append Unicode code point of each character
  }

  return buffer.toString();
}

class _StartWithErrorStreamSink<S> extends ForwardingSink<S, S> {
  _StartWithErrorStreamSink(this._e, this._st);
  final Object _e;
  final StackTrace? _st;

  @override
  void onData(S data) => sink.add(data);

  @override
  void onError(Object e, StackTrace st) => sink.addError(e, st);

  @override
  void onDone() => sink.close();

  @override
  FutureOr onCancel() {}

  @override
  void onListen() {
    sink.addError(_e, _st);
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}

/// Prepends an error to the source [Stream].
///
/// ### Example
///
///     Stream.fromIterable([2])
///       .transform(StartWithErrorStreamTransformer('error'))
///       .listen(null, onError: (e) => print(e)); // prints 'error'
class StartWithErrorStreamTransformer<S> extends StreamTransformerBase<S, S> {
  /// Constructs a [StreamTransformer] which starts with the provided [error]
  /// and then outputs all events from the source [Stream].
  StartWithErrorStreamTransformer(this.error, [this.stackTrace]);

  /// The starting error of this [Stream]
  final Object error;

  /// The starting stackTrace of this [Stream]
  final StackTrace? stackTrace;

  @override
  Stream<S> bind(Stream<S> stream) =>
      forwardStream(stream, () => _StartWithErrorStreamSink(error, stackTrace));
}
