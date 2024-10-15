import 'package:sabowsla_firestore_platform_interface/sabowsla_firestore_platform_interface.dart';

class SabowslaFirestore {
  CollectionReference collection(String path) {
    return CollectionReference(path);
  }
}

class CollectionReference {
  CollectionReference(this.path);
  final String path;

  DocumentReference doc(String documentId) {
    return DocumentReference(path: '$path/$documentId');
  }
}

class DocumentReference {
  DocumentReference({required this.path});

  final String path;

  Future<DocumentSnapshot> get() async {
    throw UnimplementedError();
  }

  Future<void> delete() {
    throw UnimplementedError();
  }

  Future<void> set(Map map) {
    throw UnimplementedError();
  }
}

class DocumentSnapshot {
  DocumentSnapshot({
    required this.id,
    required this.exists,
    required this.documentData,
  });

  final String id;
  final bool exists;
  final String documentData;

  Map<String, DocumentField> data() {
    throw UnimplementedError();
  }
}
