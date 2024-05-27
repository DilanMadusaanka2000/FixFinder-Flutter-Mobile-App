import 'package:flutter/material.dart';



class ServiceProviderPost extends StatefulWidget {
  const ServiceProviderPost({super.key});

  @override
  State<ServiceProviderPost> createState() => _ServiceProviderPostState();
}

class _ServiceProviderPostState extends State<ServiceProviderPost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(child: Text("Post Page"),),
        ),
        
      ),
    );
  }
}