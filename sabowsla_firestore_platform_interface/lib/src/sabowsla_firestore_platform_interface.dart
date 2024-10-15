import 'package:sabowsla_firestore_platform_interface/sabowsla_firestore_platform_interface.dart';

abstract class SabowslaFirestorePlatformInterface {
  CollectionReferencePlatform collection(String collectionPath);

  void updateDocument(DocumentReferencePlatformInterface document);
}
