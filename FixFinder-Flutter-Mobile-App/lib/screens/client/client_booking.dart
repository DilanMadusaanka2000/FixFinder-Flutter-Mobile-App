import 'package:checkfirebase/service/firebase_crud.dart';
import 'package:checkfirebase/service/firebase_service_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientBookin extends StatefulWidget {
  const ClientBookin({super.key});

  @override
  State<ClientBookin> createState() => _ClientBookinState();
}

class _ClientBookinState extends State<ClientBookin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Client Bookin')),
        body: user != null
            ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseRequestCrude.readRequest(email: user!.email!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var requestDocs = snapshot.data!.docs;

                  if (requestDocs.isEmpty) {
                    return const Center(child: Text('No requests found.'));
                  }

                  return ListView.builder(
                    itemCount: requestDocs.length,
                    itemBuilder: (context, index) {
                      var requestData = requestDocs[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: EdgeInsets.all(10),
                        color: const Color.fromARGB(255, 101, 183, 238),
                        child: ListTile(
                          title: Text(requestData['client_name'] ?? 'No name'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address: ${requestData['address'] ?? 'No address'}'),
                              Text('Description: ${requestData['description'] ?? 'No description'}'),
                              Text('Contact No: ${requestData['contact_no'] ?? 'No contact no'}'),
                              Text('Email: ${requestData['emil'] ?? 'No email'}'),
                              Text('Date: ${requestData['date'] ?? 'No date'}'),
                              Text('Employee Name: ${requestData['employeeName'] ?? 'No employee name'}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : const Center(child: Text('No user logged in.')),
      ),
    );
  }
}
