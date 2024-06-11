import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/sign_in.dart';
import 'package:checkfirebase/screens/client/client_main.dart';
import 'package:checkfirebase/service/firebase_service_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/response.dart';
//import 'firebase_request_crude.dart';

class HireView extends StatefulWidget {
  final String employeeName;
  final String employeeId;

  const HireView({
    Key? key,
    required this.employeeName,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<HireView> createState() => _HireViewState();
}

class _HireViewState extends State<HireView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking Request",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClientMain()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseRequestCrude.readRequestsByEmployeeId(widget.employeeId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No requests found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['client_name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address: ${data['address']}'),
                    Text('Description: ${data['description']}'),
                    Text('Contact No: ${data['contact_no']}'),
                    Text('Email: ${data['email']}'),
                    Text('Date: ${data['date']}'),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
