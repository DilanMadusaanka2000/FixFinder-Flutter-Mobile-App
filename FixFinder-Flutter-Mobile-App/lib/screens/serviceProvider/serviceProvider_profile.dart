import 'package:checkfirebase/pages/editpage.dart';
import 'package:checkfirebase/service/firebase_service_request.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:checkfirebase/service/firebase_crud.dart';
import 'package:checkfirebase/models/employer.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  int requestCount = 0;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      _fetchRequestCount();
    }
  }

  Future<void> _fetchRequestCount() async {
    if (user != null) {
      String userEmail = user!.email!;
      QuerySnapshot querySnapshot = await FirebaseCrud.readEmployeeForUser(userEmail).first;
      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        String employeeId = querySnapshot.docs.first.id; // Get the document ID
        int count = await FirebaseRequestCrude.countRequestsForEmployee(employeeId);
        setState(() { 
          requestCount = count;    // rebuild ()
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseCrud.readEmployeeForUser(user!.email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data found for the logged-in user.'));
                }

                var userData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                String docId = snapshot.data!.docs.first.id; // Get the document ID

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 20, 53, 189),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "SATURDAY, JANUARY 16",
                                    style: TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Profile",
                                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30, fontWeight: FontWeight.w800),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPage(
                                            employee: Employee(
                                              uid: docId,
                                              employeename: userData["employee_name"],
                                              position: userData["position"],
                                              contactno: userData["contact_no"],
                                              experience: userData["experience"],
                                              district: userData["district"],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      iconColor: const Color.fromARGB(255, 78, 158, 224),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text('Edit'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: const Color.fromARGB(255, 255, 254, 247),
                                backgroundImage: userData['profilePictureUrl'] != null
                                    ? NetworkImage(userData['profilePictureUrl']) as ImageProvider<Object>?
                                    : const AssetImage('assets/avatar.jpg') as ImageProvider<Object>?, // Replace with your default image asset
                              ),
                              const SizedBox(height: 10),
                              Text(
                                userData['employee_name'] ?? 'No Name',
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
                            ProfileDetailField('Full Name :', userData['employee_name']),
                            ProfileDetailField('Position:', userData['position']),
                            ProfileDetailField('Experience:', userData['experience']),
                            ProfileDetailField('District:', userData['district']),
                            ProfileDetailField('Contact No:', userData['contact_no']),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  height: 30 * 5.0,
                                  width: 20 * 5.0,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 39, 98, 247),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 12, 108, 177),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Hire \n($requestCount)', // Display the request count
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(child: Text('User not logged in.')),
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
          border: Border.all(color: const Color.fromARGB(255, 76, 172, 251)), // Add border decoration
          borderRadius: BorderRadius.circular(10), // Optional: Add border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 15), // Add some space between label and value
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
