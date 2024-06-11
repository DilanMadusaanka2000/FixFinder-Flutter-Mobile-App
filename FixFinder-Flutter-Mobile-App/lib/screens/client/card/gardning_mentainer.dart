import 'package:checkfirebase/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../../../service/firebase_crud.dart';

class GardningMentainer extends StatefulWidget {
  const GardningMentainer({super.key});

  @override
  State<GardningMentainer> createState() => _GardningMentainerState();
}

class _GardningMentainerState extends State<GardningMentainer> {
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

        // backgroundColor: Theme.of(context).primaryColor,
      ),

      //backgroundColor: kMainBkacgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCrud.readEmployee(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final employees = snapshot.data!.docs.where((doc) {
            return doc['position'] == 'Gardning';
          }).toList();

          return Container(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                var employee = employees[index];

                Column(children: [
                  // Add your photo here
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/card/Technicians.jpg',  // Replace with your image asset or network image
                      fit: BoxFit.cover,
                    ),
                  ),
                ]);







                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
