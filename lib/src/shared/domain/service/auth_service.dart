import 'package:chat_app/src/core/common/navigation.dart';
import 'package:chat_app/src/core/utils/preferences/app_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/src/core/utils/constants/app_routes.dart' as Approute;

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final AppPreferences _appPreferences = AppPreferences();
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get streamuser => _firebaseAuth.authStateChanges();

  User getCurrentUser() {
    return _firebaseAuth.currentUser!;
  }

  // Future<void> signUp(
  //     {required String email,
  //     required String password,
  //     required String nama,
  //     required noHp}) async {
  //   try {
  //     final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     // Tambahkan pengguna ke Cloud Firestore
  //     // await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
  //     //   'uid': user?.uid,
  //     //   'email': email,
  //     //   'nama': nama,
  //     //   'noHp': noHp,
  //     //   'role': 'admin'
  //     //   // tambahkan informasi lain yang ingin Anda simpan di sini
  //     // });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       throw Exception('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       throw Exception('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }

  Future<UserCredential> signIn(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({'uid': userCredential.user!.uid, 'email': email});
      }
      // _firestore
      //     .collection("Users")
      //     .doc(userCredential.user!.uid)
      //     .set({'uid': userCredential.user!.uid, 'email': email});
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> signUp(
      String email, password, String name, String number) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'number': number
      });
      // _firestore
      //     .collection("Users")
      //     .doc(userCredential.user!.uid)
      //     .set({'uid': userCredential.user!.uid, 'email': email});
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      // _appPreferences.setLoginState(false);
      await _firebaseAuth.signOut().then((user) {
        // print("sudah logout dari firebase");
        _appPreferences.setLoginState(false);
        Navigation.navigateToPageReplacement(Approute.LOGIN_ROUTE);
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
