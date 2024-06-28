import 'dart:io';
import 'package:checkfirebase/constants/colors.dart';
import 'package:checkfirebase/pages/listpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import '../service/firebase_crud.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final _employee_name = TextEditingController();
  final _employee_contact = TextEditingController();
  File? _profileImage;

  // Define a list of local service provider options
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadProfileImage(File image) async {
    try {
      String fileName = path.basename(image.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profileImages/$fileName');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
      return null;
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
          hintStyle: TextStyle(color: Colors.white),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );



    

    final positionDropdown = DropdownButtonFormField<String>(
      value: _selectedPosition,
      items: positions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedPosition = newValue;
        });
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Position",
          hintStyle: TextStyle(color: Colors.white),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a position';
        }
        return null;
      },
    );

    final districtDropdown = DropdownButtonFormField<String>(
      value: _selectedDistrict,
      items: districts.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedDistrict = newValue;
        });
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "District",
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a district';
        }
        return null;
      },
    );

    final experienceDropdown = DropdownButtonFormField<String>(
      value: _selectedExperience,
      items: experience.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedExperience = newValue;
        });
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Experience",
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select Experience';
        }
        return null;
      },
    );
    //conatct form field
    final contactField = TextFormField(
      controller: _employee_contact,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },

      keyboardType: TextInputType.number,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contact Number",
          hintStyle: TextStyle(color: Colors.white),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );




   //check enter data is number format 
    // bool isNumeric(String? str) {
    //   if (str == null) {
    //     return false;
    //   }
    //   return double.tryParse(str) != null;
    // }

    

    final viewListbutton = TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ListPage(),
          ),
          (route) => false,
        );
      },
      child: const Text('View List of Employee'),
    );

    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            String? profileImageUrl;
            if (_profileImage != null) {
              profileImageUrl = await _uploadProfileImage(_profileImage!);
            }

            var response = await FirebaseCrud.addEmployee(
              name: _employee_name.text,
              position: _selectedPosition!,
              district: _selectedDistrict!,
              contactno: _employee_contact.text,
              experience: _selectedExperience!,
              profilePictureUrl: profileImageUrl,
            );

            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Enter Your \nPersonal Details",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color:
                        kButtonColorwithBlue, // Set the background color you prefer
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                              child: _profileImage == null
                                  ? Icon(Icons.camera_alt, size: 50)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          nameField,
                          const SizedBox(height: 25.0),
                          positionDropdown,
                          const SizedBox(height: 35.0),
                          districtDropdown,
                          const SizedBox(height: 25.0),
                          experienceDropdown,
                          const SizedBox(height: 25.0),
                          contactField,
                          viewListbutton,
                          const SizedBox(height: 45.0),
                          saveButton,
                          const SizedBox(height: 15.0),
                        ],
                      ),
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
