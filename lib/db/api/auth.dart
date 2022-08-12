import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;

  Future<UserCredential> emailPasswordLogin(
      String email, String password) async {
    try {
      result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(result.user?.uid);
      return result;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    return result;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<User?> getLoggedUser() async {
    final User? user = auth.currentUser;
    return user;
  }

  Future getUserRole(String? email) async {
    CollectionReference admin =
    FirebaseFirestore.instance.collection('admin');
    final doc = await admin.where("email",isEqualTo: email).get();
    if(doc.docs.isNotEmpty){
      return "admin";
    }else{
      CollectionReference students =
      FirebaseFirestore.instance.collection('students');
      final doc = await students.where("email",isEqualTo: email).get();
      if(doc.docs.isNotEmpty){
        return "student";
      }
    }
  }
}
