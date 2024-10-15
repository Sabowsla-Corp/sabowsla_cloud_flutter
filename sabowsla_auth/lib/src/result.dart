//Result is a generic class that is used to return the result of a function.
import 'dart:convert';

abstract class Result<T> {
  T get data;
  bool get isSuccess;
  Map<String, dynamic> toMap();
  Result fromMap(Map<String, dynamic> json);
  String toRawMap() => jsonEncode(toMap());
  Result fromRawMap(String json) => fromMap(jsonDecode(json));

  @override
  String toString();
  List<Object?> get props => [];
}
