import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  final FirebaseAuth _firebase;

  AuthenticationServices(this._firebase);

  Stream<User> get authStateChange => _firebase.authStateChanges();

  Future<String> signIn({String username, String password}) async {
    try {
      await _firebase.signInWithEmailAndPassword(
          email: username, password: password);

      return "Successful";
    } catch (e) {
      return e.code;
    }
  }

  Future<String> signUp({String username, String password, String name}) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
          email: username, password: password);

      FirebaseFirestore.instance
          .collection('movieuser')
          .doc(_firebase.currentUser.uid)
          .set({
        'name': name,
        'email': username,
      });

      return "Successful";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signOut() async {
    await _firebase.signOut();

    return "Sign out Successfully";
  }

  Future<dynamic> getCurrentUser() async {
    return _firebase.currentUser;
  }

  Stream<DocumentSnapshot> getDataBase() {
    return FirebaseFirestore.instance
        .collection('movieuser')
        .doc(_firebase.currentUser.uid)
        .snapshots();
  }
}
