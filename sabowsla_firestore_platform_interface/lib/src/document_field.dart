import 'dart:convert';
import 'dart:math' as math;
//Used to store document fields to and from the document data structure

class DocumentField {
  const DocumentField({
    required this.fieldName,
    //required this.fieldType,
    required this.fieldData,
  });

  final String? fieldName;
  final dynamic fieldData;

  Map<String, dynamic>? parseFieldDataMap() {
    return null;
  }

  static String get getRandomFieldName {
    return randomFieldNames[math.Random().nextInt(randomFieldNames.length)];
  }

  static List<String> supportedFieldTypesDropDownList = [
    "int",
    "String",
    "bool",
    "List<DocumentField>",
    "_Map<String, DocumentField>",
    "Null",
  ];

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return super == other &&
        other is DocumentField &&
        other.fieldName == fieldName &&
        other.fieldData == fieldData;
  }

  String toJsonRaw() {
    return jsonEncode(toJson());
  }

  static DocumentField fromJsonRaw(String json) {
    return fromJson(jsonDecode(json));
  }

  Map<String, dynamic> toJson() {
    return {
      "fieldName": fieldName ?? "",
      "fieldData": fieldData,
    };
  }

  static DocumentField fromJson(Map<dynamic, dynamic> json) {
    return DocumentField(
      fieldName: json["fieldName"],
      fieldData: json["fieldData"],
    );
  }

  static DocumentField testDocument() => const DocumentField(
        fieldName: "name",
        fieldData: "jhon",
      );

  DocumentField copyWith({
    String? fieldName,
    dynamic fieldData,
  }) {
    return DocumentField(
      fieldName: fieldName ?? this.fieldName,
      fieldData: fieldData ?? this.fieldData,
    );
  }
}

enum DocumentFieldType { string, int, double, bool, array }

List<String> randomFieldNames = [
  "name",
  "age",
  "email",
  "address",
  "phone",
  "description",
  "title",
];
