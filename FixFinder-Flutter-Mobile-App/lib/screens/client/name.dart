import 'package:checkfirebase/models/response.dart';
import 'package:flutter/material.dart';
import '../../service/client_name.dart';

class Name extends StatefulWidget {
  const Name({super.key});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _clientNameController = TextEditingController();

  @override
  void dispose() {
    _clientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Name'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ??  false) {

                        Response response =
                        await ClientName.addName(

                          clientName:_clientNameController.text,

                        

                        );

                        if (response.code == 200) {
                              _formKey.currentState?.reset();
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Send")),
                            );



                        // Handle form submission
                        //print('Client Name: ${_clientNameController.text}');
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
