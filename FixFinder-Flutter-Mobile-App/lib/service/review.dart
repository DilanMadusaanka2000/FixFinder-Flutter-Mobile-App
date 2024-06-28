import 'package:checkfirebase/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'review.dart';

class ReviewProvider with ChangeNotifier {
  final List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  void addReview(Review review) async {
    await FirebaseFirestore.instance.collection('reviews').add(review.toMap());
    _reviews.add(review);
    notifyListeners();
  }

  void fetchReviews() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('reviews').get();
    _reviews.clear();
    querySnapshot.docs.forEach((doc) {
      _reviews.add(Review.fromMap(doc.data()));
    });
    notifyListeners();
  }
}
