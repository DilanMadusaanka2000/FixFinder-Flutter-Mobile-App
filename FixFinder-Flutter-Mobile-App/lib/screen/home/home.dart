import 'package:checkfirebase/pages/addpage.dart';
import 'package:checkfirebase/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //create a obj from  AuthServie
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.blue,
          actions: [
            ElevatedButton(
                onPressed: () async {
                 await  _auth.signOut();
                },
                child: const Icon(Icons.logout)
                ),






  //crud operation check
                   ElevatedButton(
              onPressed: () {
                // Navigate to the second Dart file
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
              },
              child: const Text("Go to Second Page"),
            ),





          ],
        ),
      ),

      //child: Text("Home"),
    );
  }
}
