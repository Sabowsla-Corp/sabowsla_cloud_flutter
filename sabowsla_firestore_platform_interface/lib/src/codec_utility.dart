// ignore_for_file: unnecessary_lambdas

import 'dart:convert';

import 'package:sabowsla_firestore_platform_interface/src/document_field.dart';

class CodecUtility {
  static String? encodeDocumentFields(Map<String, DocumentField> data) {
    if (data.isNotEmpty) {
      var encodedResult = json.encode(data);
      return encodedResult;
    }
    return null;
  }

  static Map<String, DocumentField>? decodeDocumentFields(String? json) {
    if (json != null) {
      var decodedJson = jsonDecode(json);
      if (decodedJson is Map) {
        Map<String, DocumentField> newJson = {};
        for (MapEntry field in decodedJson.entries) {
          var document =
              DocumentField.fromJson(field.value as Map<String, dynamic>);
          newJson[field.key] = document;
        }

        return newJson;
      }
    }
    return null;
  }
}
