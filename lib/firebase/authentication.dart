import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        'LikedMovies': {},
      });

      return "Successful";
    } on FirebaseAuthException catch (e) {
      return e.code;
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

  Stream<DocumentSnapshot> searchData(int id) {
    return FirebaseFirestore.instance
        .collection("movieuser")
        .doc(_firebase.currentUser.uid)
        .snapshots()
        .where((event) {
      List<dynamic> values = List();
      event["LikedMovies"].forEach((k, v) => values.add(k));

      for (int i = 0; i < values.length; i++) {
        if (values[i] == id.toString()) {
          return true;
        }
      }
      return false;
    });
  }

  Future<dynamic> addData(int id, String name, String image) {
    return FirebaseFirestore.instance
        .collection('movieuser')
        .doc(_firebase.currentUser.uid)
        .update({
      "LikedMovies.$id": {
        "id": id,
        "title": name,
        "image": image,
      }
    });
  }

  Future<dynamic> removeData(int id) {
    return FirebaseFirestore.instance
        .collection('movieuser')
        .doc(_firebase.currentUser.uid)
        .update({"LikedMovies.${id.toString()}": FieldValue.delete()});
  }

  Future<dynamic> addField() {
    return FirebaseFirestore.instance
        .collection('movieuser')
        .doc(_firebase.currentUser.uid)
        .update({'LikedMovies': {}});
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    User user;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      user = userCredential.user;

      googleSignIn.signOut();
      FirebaseFirestore.instance
          .collection('movieuser')
          .doc(user.uid)
          .get()
          .then((value) {
        if (!value.exists)
          return FirebaseFirestore.instance
              .collection('movieuser')
              .doc(user.uid)
              .set({
            'email': user.email,
            'name': user.displayName,
          });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        return "Already Exist";
      } else if (e.code == "invalid-credential") {
        return "Invalid Credentials";
      }
    } catch (e) {
      return "Error";
    }

    return "Successful";
  }
}
