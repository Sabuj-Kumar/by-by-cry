import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static const String collectionUser = 'Users';
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isUser(String uid) async {
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }
}