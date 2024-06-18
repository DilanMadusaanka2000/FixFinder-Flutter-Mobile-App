// firebase_crud.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCrud {
  static Future<void> addReview(String employeeId, String review, int rating) async {
    final user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      await FirebaseFirestore.instance.collection('reviews').add({
        'employeeId': employeeId,
        'userId': user.uid,
        'review': review,
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    
  }

  static Future<void> updateReview(String reviewId, String review, int rating) async {
    await FirebaseFirestore.instance.collection('reviews').doc(reviewId).update({
      'review': review,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> deleteReview(String reviewId) async {
    await FirebaseFirestore.instance.collection('reviews').doc(reviewId).delete();
  }




  static Stream<QuerySnapshot> getReviews(String employeeId) {
    return FirebaseFirestore.instance
        .collection('reviews')
        .where('employeeId', isEqualTo: employeeId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
