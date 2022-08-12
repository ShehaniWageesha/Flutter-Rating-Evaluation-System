import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_sliit/db/model/support_request.dart';

class UserApi {
  Future addSupport(Support support) async {
    CollectionReference students =
        FirebaseFirestore.instance.collection('support');
    try {
      await students.add(support.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateSupport(DocumentSnapshot? documentSnapshot, Support support) async {
    CollectionReference students =
    FirebaseFirestore.instance.collection('support');
    try {
      await students.doc(documentSnapshot?.id).update(support.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteSupport(DocumentSnapshot? documentSnapshot) async {
    CollectionReference students =
    FirebaseFirestore.instance.collection('support');
    try {
      await students.doc(documentSnapshot?.id).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllSupportReq() async {
    CollectionReference supports =
    FirebaseFirestore.instance.collection('support');
    final teacherListDoc = await supports.get();
    return teacherListDoc.docs;
  }
}
