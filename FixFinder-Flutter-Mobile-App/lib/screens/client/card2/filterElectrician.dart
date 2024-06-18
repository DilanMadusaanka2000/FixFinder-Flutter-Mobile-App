import 'package:checkfirebase/screens/client/client_main.dart';
import 'package:checkfirebase/screens/request/client_request.dart';
import 'package:checkfirebase/screens/serviceProvider/Profile_client_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../service/firebase_crud.dart';

class Filterelectrician extends StatefulWidget {
  final String selectedValue;
  const Filterelectrician({super.key, required this.selectedValue});

  @override
  State<Filterelectrician> createState() => _FilterelectricianState();
}

class _FilterelectricianState extends State<Filterelectrician> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Electricians",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClientMain()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/card/electricity.png',
            height: 260,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseCrud.readEmployee(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final employees = snapshot.data!.docs.where((doc) {
                  return doc['position'] == 'Electrician' && doc['district'] == widget.selectedValue;
                }).toList();

                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    Color backgroundColor = (index % 2 == 0) ? Colors.blue : Colors.white;
                    Color textColor = (index % 2 == 0) ? Colors.white : Colors.black;
                    var employee = employees[index];

                    return Card(
                      color: backgroundColor,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: employee['profilePictureUrl'] != null ? NetworkImage(employee['profilePictureUrl']) : null,
                          child: employee['profilePictureUrl'] == null ? Icon(Icons.person) : null,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            employee['employee_name'],
                            style: TextStyle(
                              color: textColor,
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
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: textColor,
                              ),
                            ),
                            Text(
                              'Contact No: ${employee['contact_no']}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: textColor,
                              ),
                            ),
                            Text(
                              'District: ${employee['district']}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: textColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CLientViewProfile(
                                          employeeName: employee['employee_name'],
                                          employeeId: employee.id,
                                        ),
                                      ),
                                    );
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
