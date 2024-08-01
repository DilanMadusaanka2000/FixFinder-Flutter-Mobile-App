import 'package:checkfirebase/screens/request/client_review.dart';
import 'package:checkfirebase/service/firebase_service_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:checkfirebase/service/firebase_crud.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  int requestCount = 0;
  String currentUserName = '';

  Map<String, dynamic>? employeeData;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;

    fetchEmployeeData();
    if (user != null) {
      _fetchRequestCount();
      _fetchClientName();
    }
  }

  Future<void> _fetchRequestCount() async {
    int count =
        await FirebaseRequestCrude.countRequestsForEmployee(widget.employeeId);
    setState(() {
      requestCount = count; // rebuild ()
    });
  }

  Future<void> _fetchClientName() async {
    try {
      if (user != null) {
        String? userEmail = user!.email;
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Projects')
            .where('email', isEqualTo: userEmail)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            currentUserName = (querySnapshot.docs.first.data() as Map<String, dynamic>)['client_name'] ?? '';

          });
        }else{
           print('No matching user found in Projects collection');
        }
      }
    } catch (e) {
      print('Error fetching client name: $e');
    }
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
          "Home",
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
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 40.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 40.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 254, 247),
                            backgroundImage:
                                employeeData!['profilePictureUrl'] != null
                                    ? NetworkImage(
                                        employeeData!['profilePictureUrl'])
                                    : const AssetImage('assets/avatar.jpg')
                                        as ImageProvider<Object>?,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.employeeName,
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
                        ProfileDetailField(
                            'Position:', employeeData!['position']),
                        ProfileDetailField(
                            'Experience:', employeeData!['experience']),
                        ProfileDetailField(
                            'District:', employeeData!['district']),
                        ProfileDetailField(
                            'Contact No:', employeeData!['contact_no']),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Hire',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Works",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent[300]),
                      ),
                      Text(
                        " $requestCount",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientReviewScreen(
                                  employeeId: widget.employeeId,
                                   clientName: currentUserName),
                            ),
                          );
                        },
                        child: Text('Reviews & Ratings'),
                       
                      ),
                     ElevatedButton.icon(
                   onPressed: () {
                    _openDialer(employeeData!['contact_no']);
                        },
                      icon:const Icon(
                         Icons.phone, // Replace with your desired icon (e.g., Icons.call)
                         color: Colors.white, // Adjust icon color if needed
                         ),
                       label: Text(
                          'Call',
                        style: TextStyle(color: Colors.white),
                        ),
                       style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Change to your desired color
                       ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }


//phone call method 
  void _openDialer(String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(_phoneLaunchUri)) {
        await launch(_phoneLaunchUri.toString());
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      print('Error: $e');
    }
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
          border: Border.all(color: const Color.fromARGB(255, 76, 172, 251)),
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
