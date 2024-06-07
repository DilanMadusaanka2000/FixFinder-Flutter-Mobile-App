import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:checkfirebase/service/firebase_crud.dart';

class CLientViewProfile extends StatefulWidget {
  final String employeeName;
  final String employeeId;

  const CLientViewProfile({
    Key? key,
    required this.employeeName,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<CLientViewProfile> createState() => _CLientViewProfileState();
}

class _CLientViewProfileState extends State<CLientViewProfile> {
  Map<String, dynamic>? employeeData;

  @override
  void initState() {
    super.initState();
    fetchEmployeeData();
  }

  void fetchEmployeeData() async {
    try {
      DocumentSnapshot employeeSnapshot = await FirebaseFirestore.instance
          .collection('Employee')
          .doc(widget.employeeId)
          .get();
      if (employeeSnapshot.exists) {
        setState(() {
          employeeData = employeeSnapshot.data() as Map<String, dynamic>?;
        });
      } else {
        print('Employee data not found!');
      }
    } catch (e) {
      print('Error fetching employee data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Profile",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
      ),




      
      body: employeeData != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 20, 53, 189),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),

                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 40.0),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SATURDAY, JANUARY 16",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                       const   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Profile",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800),
                              ),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     // Navigate to edit page
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => EditPage(
                              //           employee: Employee(
                              //             uid: widget.employeeId,
                              //             employeename: widget.employeeName,
                              //             position: employeeData!["position"],
                              //             contactno: employeeData!["contact_no"],
                              //             experience: employeeData!["experience"],
                              //             district: employeeData!["district"],
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     iconColor:
                              //         const Color.fromARGB(255, 78, 158, 224),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              //   child: const Text('Edit'),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 254, 247),
                            backgroundImage: employeeData!['profilePictureUrl'] !=
                                    null
                                ? NetworkImage(
                                    employeeData!['profilePictureUrl'])
                                : const AssetImage('assets/avatar.jpg')
                                    as ImageProvider<Object>?,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.employeeName ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ProfileDetailField('Full Name :', widget.employeeName),
                        ProfileDetailField('Position:',
                            employeeData!['position']),
                        ProfileDetailField('Experience:',
                            employeeData!['experience']),
                        ProfileDetailField('District:',
                            employeeData!['district']),
                        ProfileDetailField('Contact No:',
                            employeeData!['contact_no']),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}








class ProfileDetailField extends StatelessWidget {
  final String label;
  final String value;

  ProfileDetailField(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border:
              Border.all(color: const Color.fromARGB(255, 76, 172, 251)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
