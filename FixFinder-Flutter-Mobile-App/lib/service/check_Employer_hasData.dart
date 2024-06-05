

 // check if has the data related to reg email 

import 'package:checkfirebase/pages/addpage.dart';
import 'package:checkfirebase/screens/serviceProvider/serviceProvider_profile.dart';
import 'package:flutter/material.dart';
import 'package:checkfirebase/service/firebase_crud.dart';
//import 'package:checkfirebase/screen/profile.dart';
//import 'package:checkfirebase/screen/addlist.dart';

class CheckEmployeeData extends StatelessWidget {
  const CheckEmployeeData({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: FirebaseCrud.employeeDataExists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());    
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error checking data'));
        } else if (snapshot.data == true) {
          return Profile(); // Load Profile dart
        } else {
          return AddPage(); // Load AddList dart 
        }
      },
    );
  }
}
