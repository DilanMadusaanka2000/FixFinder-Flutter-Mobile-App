import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClientReviewScreen extends StatefulWidget {
  final String employeeId;

  const ClientReviewScreen({Key? key, required this.employeeId}) : super(key: key);

  @override
  _ClientReviewScreenState createState() => _ClientReviewScreenState();
}

class _ClientReviewScreenState extends State<ClientReviewScreen> {
  
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 0;

  void _submitReview() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && _rating > 0 && _reviewController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('reviews').add({
          'employeeId': widget.employeeId,
          'userId': user.uid,
          'review': _reviewController.text,
          'rating': _rating,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _reviewController.clear();
        setState(() {
          _rating = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review submitted successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error submitting review: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please provide a rating and a review')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews & Ratings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(labelText: 'Write a review'),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            Text('Rate the employee'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              child: Text('Submit Review'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('reviews')
                    .where('employeeId', isEqualTo: widget.employeeId)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    if (snapshot.error.toString().contains('FAILED_PRECONDITION')) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('The query requires an index.'),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Provide instructions or link to create the index
                                // Open the index creation URL in a browser
                              },
                              child: Text('Create Index'),
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No reviews yet'));
                  }
                  final reviews = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ListTile(
                        title: Text(review['review']),
                        subtitle: Text('Rating: ${review['rating']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
