import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User data variables
  String? _employeename;
  String? _position;
  String? _district;
  String? _contactno;

  // Method to fetch user-specific data from Firestore
// Method to fetch user-specific data from Firestore using the logged-in user's email
Future<void> getUserData() async {
  final User? user = _auth.currentUser;
  if (user != null) {
    final QuerySnapshot userData = await _firestore
        .collection('Employee')
        .where('email', isEqualTo: user.email) // Filter by user's email
        .get();

    if (userData.docs.isNotEmpty) {
      final userDocument = userData.docs.first;
      setState(() {
        _employeename = userDocument['employee_name'];
        _position = userDocument['position'];
        _district = userDocument['district'];
        _contactno = userDocument['contact_no'];
      });
    }
  }
}


  @override
  void initState() {
    super.initState();
    getUserData(); // Fetch user-specific data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


  





     
    );
  }
}
















//  appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Name: $_employeename',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             Text(
//               'Position: $_position',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             Text(
//               'District: $_district',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             Text(
//               'Contact: $_contactno',
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ],
//         ),
      // ),