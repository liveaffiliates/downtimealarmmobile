import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> updateFirestoreDocument(Map<String, dynamic> data, String collection, String id) {
  return Firestore.instance.runTransaction((Transaction transactionHandler) {
    return Firestore.instance
        .collection(collection)
        .document(id)
        .setData(data, merge: true);
  });
}
