import 'package:checkfirebase/constants/colors.dart';
import 'package:checkfirebase/screens/request/client_request.dart';
import 'package:checkfirebase/screens/serviceProvider/Profile_client_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../../../service/firebase_crud.dart';

class Carpenter extends StatefulWidget {
  const Carpenter({super.key});

  @override
  State<Carpenter> createState() => _CarpenterState();
}

class _CarpenterState extends State<Carpenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          " Carpenter",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),

        // backgroundColor: Theme.of(context).primaryColor,
      ),

      //backgroundColor: kMainBkacgroundColor,
      body: Column(
        children: [
          Image.asset(
            'assets/card/carpenter.png',
            height: 260, // Adjust the height as needed
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
                  return doc['position'] == 'Carpenter';
                }).toList();

                return Container(
                  child: ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      Color backgroundColor =
                          (index % 2 == 0) ? Colors.blue : Colors.white;
                      Color textColor =
                          (index % 2 == 0) ? Colors.white : Colors.black;
                      var employee = employees[index];

                      Column(children: [
                        // Add your photo here
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/card/Technicians.jpg', // Replace with your image asset or network image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]);

                      return Card(
                        color: backgroundColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: employee['profilePictureUrl'] !=
                                    null
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
                                    color: textColor),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CLientViewProfile(
                                          employeeName:
                                              employee['employee_name'],
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
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
