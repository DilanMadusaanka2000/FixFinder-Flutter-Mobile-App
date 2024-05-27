import 'package:flutter/material.dart';



class ClientFav extends StatefulWidget {
  const ClientFav({super.key});

  @override
  State<ClientFav> createState() => _ClientFavState();
}

class _ClientFavState extends State<ClientFav> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(child: Text("Fav Page"),),
        ),
        
      ),
    );
  }
}