import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:edumate/state/constants/firebase_collection_name.dart';
import 'package:edumate/state/constants/firebase_field_name.dart';
import 'package:edumate/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required String userId,
    required String? displayName,
    required String? email,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // check if the user already exists
      final userInfo = await firestore
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .limit(1)
        .get();
      if (userInfo.docs.isNotEmpty) {
      // we already have this user's information
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? "",
        });
        return true;
      }
    final payload = UserInfoPayload(userId: userId, displayName: displayName, email: email);
    await firestore.collection(FirebaseCollectionName.users).add(payload);
    return true;
    } catch (e) {
      return false;
    }

  }
}
