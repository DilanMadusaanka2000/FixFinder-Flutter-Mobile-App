import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/response.dart';
import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/sign_in.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Projects');

class ClientName {
  //create name
  

  static Future<Response> addName({
    required String clientName,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    String? userEmail = user?.email;

    Map<String, dynamic> data = <String, dynamic>{
      "client_name": clientName,
      "email": userEmail,
    };

    try {
      await documentReferencer.set(data);
      response.code = 200;
      response.message = "Successfully added to the database";
    } catch (e) {
      if (e is FirebaseException) {
        response.code = 500;
        response.message = e.message ?? "An error occurred";
      } else {
        response.code = 500;
        response.message = "An unexpected error occurred";
      }
    }

    return response;
  }

  //read name

  static Stream<QuerySnapshot> readClientName() {
    CollectionReference notesItemCollection = _Collection;
    return notesItemCollection.snapshots();
  }

  
}
