// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add user to Firestore
  Future<void> addUser(UserModel user) async {
    try {
      await _db.collection('users').add(user.toMap());
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  // Fetch all users from Firestore
  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot snapshot = await _db.collection('users').get();
      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching users from Firestore: $e');
      return [];
    }
  }

  // Fetch a single user by ID from Firestore
  Future<UserModel?> getUserById(String id) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(id).get();
      return doc.exists ? UserModel.fromMap(doc.data() as Map<String, dynamic>) : null;
    } catch (e) {
      print('Error fetching user from Firestore: $e');
      return null;
    }
  }

  // Update a user in Firestore
  Future<void> updateUser(String id, UserModel user) async {
    try {
      await _db.collection('users').doc(id).update(user.toMap());
    } catch (e) {
      print('Error updating user in Firestore: $e');
    }
  }

  // Delete a user from Firestore
  Future<void> deleteUser(String id) async {
    try {
      await _db.collection('users').doc(id).delete();
    } catch (e) {
      print('Error deleting user from Firestore: $e');
    }
  }
}
