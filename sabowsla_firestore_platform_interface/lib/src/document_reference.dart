import 'package:sabowsla_firestore_platform_interface/sabowsla_firestore_platform_interface.dart';

abstract class DocumentReferencePlatformInterface {
  DocumentReferencePlatformInterface({
    required this.path,
    this.id = 0,
    this.delegate,
  });

  int? id;

  final String path;

  String? parentPath();

  String get documentId;

  String? stringData;

  final SabowslaFirestorePlatformInterface? delegate;

  void set(Map<String, DocumentField> data);

  Map<String, DocumentField> data();
}
