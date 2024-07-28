import 'package:checkfirebase/screens/client/card2/filterElectrician.dart';
import 'package:checkfirebase/screens/client/client_home.dart';
import 'package:checkfirebase/screens/client/client_main.dart';
import 'package:checkfirebase/screens/request/client_request.dart';
import 'package:checkfirebase/screens/serviceProvider/Profile_client_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'client_main.dart';
import '../../../service/firebase_crud.dart';
//import 'Profile_client_view.dart';
//import 'client_request.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Container(
                    margin: EdgeInsets.all(10), // Adjust margin as needed
                     child: ElevatedButton(
                       onPressed: () => _showDialog(context),
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Color.fromARGB(255, 0, 0, 0), // Background color
                         //onPrimary: Colors.white, // Text color
                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                       ),
                     ),
                        child: Text("Filter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
            ],
            )
              ,

          // Adding the PNG file below the AppBar
          Image.asset(
            'assets/card/electricity.png',
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
                  return doc['position'] == 'Electrician';
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
                            style:  TextStyle(
                              color:textColor,
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
                              style:  TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: textColor
                              ),
                            ),
                            Text(
                              'Contact No: ${employee['contact_no']}',
                              style:  TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: textColor,
                              ),
                            ),
                            Text(
                              'District: ${employee['district']}',
                              style:  TextStyle(
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
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedValue;
        return AlertDialog(
          title: Text('District'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButton<String>(
                    hint: Text('Select District'),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                      if (newValue != null) {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Filterelectrician(selectedValue: newValue),
                          ),
                        );
                      }
                    },
                    items: <String>[ 'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya',
    'Galle',
    'Matara',
    'Hambantota',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Mullaitivu',
    'Vavuniya',
    'Puttalam',
    'Kurunegala',
    'Anuradhapura',
    'Polonnaruwa',
    'Badulla',
    'Monaragala',
    'Ratnapura',
    'Kegalle',
    'Ampara',
    'Batticaloa',
    'Trincomalee'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
