import 'package:checkfirebase/pages/editpage.dart';
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

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
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
                          color: Colors.blue,
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Profile",
                                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.yellow,
                                backgroundImage: userData['profilePictureUrl'] != null
                                    ? NetworkImage(userData['profilePictureUrl']) as ImageProvider<Object>?
                                    : const AssetImage('assets/avatar.jpg') as ImageProvider<Object>?, // Replace with your default image asset
                              ),
                              const SizedBox(height: 10),
                              Text(
                                userData['employee_name'] ?? 'No Name',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Edit Account'),
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
