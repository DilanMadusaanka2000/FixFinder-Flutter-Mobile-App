import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewRequest extends StatefulWidget {
  final String employeeName;
  final String employeeId;

  const ViewRequest({
    Key? key,
    required this.employeeName,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<ViewRequest> createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  List<DocumentSnapshot> requestList = []; // List to store fetched requests

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      fetchRequests();
    }
  }

  void fetchRequests() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Request')
          .where('employeeId', isEqualTo: widget.employeeId)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          requestList = querySnapshot.docs; // Assign all fetched documents to requestList
        });
      } else {
        print('No requests found for employee ID: ${widget.employeeId}');
      }
    } catch (e) {
      print('Error fetching requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Requests"),
      ),
      body: requestList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: requestList.length,
              itemBuilder: (context, index) {
                var requestData = requestList[index].data() as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Client Name: ${requestData['client_name']}',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Address: ${requestData['address']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Description: ${requestData['description']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Contact Number: ${requestData['contact_no']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Email: ${requestData['emil']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Date: ${requestData['date']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        // Text(
                        //   'Employee Name: ${requestData['employeeName']}',
                        //   style: TextStyle(fontSize: 16.0),
                        // ),
                        SizedBox(height: 10.0),
                        Row(
                          
                        mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                               Text("Make Completed", style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        ],)
                       
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
