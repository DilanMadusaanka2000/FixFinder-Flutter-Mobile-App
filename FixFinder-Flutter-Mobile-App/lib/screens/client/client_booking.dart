import 'package:flutter/material.dart';



class ClientBookin extends StatefulWidget {
  const ClientBookin({super.key});

  @override
  State<ClientBookin> createState() => _ClientBookinState();
}

class _ClientBookinState extends State<ClientBookin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(child: Text("Booking Page"),),
        ),
        
      ),
    );
  }
}