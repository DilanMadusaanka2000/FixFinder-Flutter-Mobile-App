import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/response.dart';
import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/sign_in.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Request');


class FirebaseRequestCrude {
  //create request
  static Future<Response> createRequest({
    required String clientname,
    required String address,
    required String descreption,
    required String contactno,
    required String date,
    required String employeeName,
    required String employeeId,
    required String location,

  }) async {
    Response response = Response();
    DocumentReference documentReference = _Collection.doc();

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    String? userEmail = user?.email;

    Map<String, dynamic> data = <String, dynamic>{
      "client_name": clientname,
      "address": address,
      "description": descreption,
      "contact_no": contactno,
      "emil": userEmail,
      "date": date,
      "employeeName": employeeName,
      "employeeId": employeeId,
      "location":location,

      // "serviceProviderId":serviceProviderID,
    };

    try {
      await documentReference.set(data);
      response.code = 200;
      response.message = "Successfully added to the database";
    } catch (e) {
      if (e is FirebaseException) {
        response.code = 500;
        response.message = e.message ?? "An error occurred ";
      } else {
        response.code = 500;
        response.message = "An unexpected error occurred";
      }
    }

    return response;
  }

  //reade request

  static Stream<QuerySnapshot> readRequest({required String? email}) {
    CollectionReference requestCollection = _Collection;
    return requestCollection.where('emil', isEqualTo: email).snapshots();

    //return notesItemCollection.snapshots();
  }


  //GET hirring request details

  static Stream<QuerySnapshot> readRequestsByEmployeeId(String employeeId) {
    return _Collection.where('employeeId', isEqualTo: employeeId).snapshots();
  }

  //delete request

  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

//update request

//fetch data related to user

  static Future<int> countRequestsForEmployee(String employeeId) async {
    QuerySnapshot querySnapshot =
        await _Collection.where('employeeId', isEqualTo: employeeId).get();

    return querySnapshot.size;
  }
}
