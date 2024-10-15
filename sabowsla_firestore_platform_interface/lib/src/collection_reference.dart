import 'package:sabowsla_firestore_platform_interface/sabowsla_firestore_platform_interface.dart';

abstract class CollectionReferencePlatform {
  CollectionReferencePlatform({
    required this.path,
    this.id = 0,
  });

  int id;

  final String path;

  int? parentId;

  SabowslaFirestorePlatformInterface? delegate;

  DocumentReferencePlatformInterface doc([String? path]);

  List<DocumentReferencePlatformInterface> get({
    int start = 0,
    int end = 100,
  });
}
