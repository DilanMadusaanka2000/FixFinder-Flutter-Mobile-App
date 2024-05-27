
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:checkfirebase/models/employer.dart';
import 'package:checkfirebase/pages/addpage.dart';
import 'package:checkfirebase/pages/editpage.dart';
import 'package:flutter/material.dart';

import '../../../service/firebase_crud.dart';

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

        title: const Text("List Of electriciasns "),
        backgroundColor: Theme.of(context).primaryColor,
      ),



      body:Text("This is "),







    );
  }
}