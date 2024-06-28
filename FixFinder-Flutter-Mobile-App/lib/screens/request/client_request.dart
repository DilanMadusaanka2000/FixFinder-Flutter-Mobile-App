import 'package:checkfirebase/screens/client/client_main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../service/firebase_service_request.dart'; // Import the CRUD service
import '../../models/response.dart';


class ClientRequest extends StatefulWidget {
  final String employeeName;
  final String employeeId;

  const ClientRequest({
    Key? key,
    required this.employeeName,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<ClientRequest> createState() => _ClientRequestState();
}

class _ClientRequestState extends State<ClientRequest> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _clientNameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _contactNoController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hire Now',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClientMain()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Adding the PNG file below the AppBar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/card/request.png',
                height: 200, // Adjust the height as needed
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _clientNameController,
                        decoration: InputDecoration(labelText: 'Client Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: 'Address'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _contactNoController,
                        decoration:
                            InputDecoration(labelText: 'Contact Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  _dateController.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                     
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            Response response =
                                await FirebaseRequestCrude.createRequest(
                              clientname: _clientNameController.text,
                              address: _addressController.text,
                              descreption: _descriptionController.text,
                              contactno: _contactNoController.text,
                              date: _dateController.text,
                              location: _locationController.text,
                              employeeName: widget.employeeName,
                              employeeId: widget.employeeId,
                            );

                            if (response.code == 200) {
                              _formKey.currentState?.reset();
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Send")),
                            );
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
