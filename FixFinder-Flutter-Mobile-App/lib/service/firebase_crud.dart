import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/response.dart';
import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/sign_in.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Employee');
class FirebaseCrud {
//CRUD method here


//create employer

static Future<Response> addEmployee({
  //required String? profilePictureUrl,
  required String name,
  required String position,
    required String experience,

  required String district,
  required String contactno,
   String? profilePictureUrl,
}) async {
  Response response = Response();
  DocumentReference documentReferencer = _Collection.doc();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = await _auth.currentUser;
  String? userEmail = user?.email;

  Map<String, dynamic> data = <String, dynamic>{
    //'profilePictureUrl': profilePictureUrl,
    "employee_name": name,
    "position": position,
    "experience":experience,

    "district": district, // Use the district value
    "contact_no": contactno,
    "email": userEmail,
     "profilePictureUrl": profilePictureUrl,
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



  //reade emp



    static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }



  //update emp



  static Future<Response> updateEmployee({
    required String name,
    required String position,
    required String distric,
    required String contactno,
    required String docId,
    required String experience,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "district":distric,
      "contact_no" : contactno,
      "experience":experience,
    };
    print('Document ID to update: $docId'); // Debugging


     try {
    await documentReferencer.update(data);
    response.code = 200;
    response.message = "Successfully updated Employee";
  } catch (e) {
    response.code = 500;
    response.message = e is FirebaseException ? e.message ?? "An error occurred" : "An unexpected error occurred";
  }

        return response;
  }








  //delete emp




  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
     Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
          response.code = 200;
          response.message = "Sucessfully Deleted Employee";
        })
        .catchError((e) {
           response.code = 500;
            response.message = e;
        });

   return response;
  }


  //check the collection has data related to the Registration email


  static Future<bool> employeeDataExists() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = await _auth.currentUser;
    String? userEmail = user?.email;

    if (userEmail == null) {
      return false;
    }

    QuerySnapshot querySnapshot = await _Collection.where('email', isEqualTo: userEmail).get();

    return querySnapshot.docs.isNotEmpty;
  }






// reade logine user data 

static Stream<QuerySnapshot> readEmployeeForUser(String userEmail) {
  
     print('Querying for email: $userEmail');
    return _Collection.where('email', isEqualTo: userEmail).snapshots();

  }




}