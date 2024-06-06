import 'package:checkfirebase/constants/colors.dart';
import 'package:checkfirebase/models/employer.dart';
import 'package:checkfirebase/screens/request/client_request.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../../../service/firebase_crud.dart';

class Electrician extends StatefulWidget {
  const Electrician({super.key});

  @override
  State<Electrician> createState() => _ElectricianState();
}

class _ElectricianState extends State<Electrician> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          " Electricians",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCrud.readEmployee(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final employees = snapshot.data!.docs.where((doc) {
            return doc['position'] == 'Electrician';
          }).toList();

          return Container(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                var employee = employees[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: employee['profilePictureUrl'] != null
                          ? NetworkImage(employee['profilePictureUrl'])
                          : null,
                      child: employee['profilePictureUrl'] == null
                          ? Icon(Icons.person)
                          : null,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        employee['employee_name'],
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Experience: ${employee['experience']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          'Contact No: ${employee['contact_no']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          'District: ${employee['district']}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Handle view button press
                              },
                              child: Text('View'),
                            ),
                            TextButton(
                          onPressed: () {
                              Navigator.push(
                                   context,
                                MaterialPageRoute(
                                 builder: (context) => ClientRequest(
                                  employeeName: employee['employee_name'],
                                    employeeId: employee.id,
                                        ),
                                          ),
                                     );
                                          },

                              child: Text('Hire'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
