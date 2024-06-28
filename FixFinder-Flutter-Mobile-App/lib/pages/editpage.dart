import 'package:checkfirebase/pages/listpage.dart';
import 'package:checkfirebase/screens/client/client_home.dart';
import 'package:checkfirebase/screens/client/client_main.dart';
import 'package:checkfirebase/screens/serviceProvider/serviceProvider_profile.dart';
import 'package:flutter/material.dart';

import '../models/employer.dart';
import '../service/firebase_crud.dart';

class EditPage extends StatefulWidget {
  final Employee? employee;
  EditPage({this.employee});

  // Create drop down lists

  List<String> positions = [
    'Mason',
    'Carpenter',
    'Plumber',
    'Electrician',
    'Painter'
  ];
  List<String> districts = [
    'Colombo',
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
    'Trincomalee'
  ];
  List<String> experience = [
    '1 Year',
    '2 Year',
    '3 Year',
    '4 Year',
    '5 Year',
    '6 Year',
    '7 Year',
    '8 Year',
    '9 Year',
    '10 Year'
  ];

  String? _selectedPosition;
  String? _selectedDistrict;
  String? _selectedExperience;

  @override
  State<StatefulWidget> createState() {
    return _EditPage();
  }

}

class _EditPage extends State<EditPage> {
  final _employee_name = TextEditingController();
  final _employee_position = TextEditingController();
  final _employee_contact = TextEditingController();
  final _employee_experience = TextEditingController();
  final _employee_distric = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _docid.text = widget.employee!.uid ?? "";
      _employee_name.text = widget.employee!.employeename ?? "";
      _employee_position.text = widget.employee!.position ?? "";
      _employee_contact.text = widget.employee!.contactno ?? "";
      _employee_experience.text = widget.employee!.experience ?? "";
      _employee_distric.text = widget.employee!.district ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: _employee_name,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final positionField = TextFormField(
      controller: _employee_position,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Position",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final experienceField = TextFormField(
      controller: _employee_experience,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Experience",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );


 //district
     final districtField = DropdownButtonFormField<String>(
      value: widget._selectedDistrict,
      items: widget.districts.map((String district) {
        return DropdownMenuItem<String>(
          value: district,
          child: Text(district),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          widget._selectedDistrict = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a district';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "District",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );



    final contactField = TextFormField(
      controller: _employee_contact,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Contact Number",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final viewListButton = Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ClientMain(),
            ),
            (route) => false,
          );
        },
        child: const Text(
          'View Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            print('Updating document ID: ${_docid.text}'); // Debugging
            var response = await FirebaseCrud.updateEmployee(
              name: _employee_name.text,
              position: _employee_position.text,
              contactno: _employee_contact.text,
              experience: _employee_experience.text,
              distric: _employee_distric.text,
              docId: _docid.text,
            );
            if (response.code != 200) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                },
              );
            }
          }
        },
        child: Text(
          "Update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text(
            'Edit  Profile',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClientHome()));
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 98, 158, 241),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70),
                topRight: Radius.circular(70),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 25.0),
                        const Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        ),
                        nameField,
                        const SizedBox(height: 25.0),
                        const Text(
                          "Position",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        ),
                        positionField,
                        const SizedBox(height: 25.0),
                        const Text(
                          "Experience",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        ),
                        experienceField,
                        const SizedBox(height: 25.0),
                        const Text(
                          "District",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        ),
                        districtField,
                        const SizedBox(height: 25.0),
                        const Text(
                          "Contact",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        ),
                        contactField,
                        viewListButton,
                        const SizedBox(height: 45.0),
                        saveButton,
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}