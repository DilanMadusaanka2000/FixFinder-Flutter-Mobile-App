import 'package:checkfirebase/screens/client/client_booking.dart';
import 'package:checkfirebase/screens/client/client_fav.dart';
import 'package:checkfirebase/screens/client/client_home.dart';
import 'package:checkfirebase/screens/client/serviceProvider_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientMain extends StatefulWidget {
  const ClientMain({super.key});

  @override
  State<ClientMain> createState() => _ClientMainState();
}

class _ClientMainState extends State<ClientMain> {
  int _currentIndex = 0;
  final List<Widget> _pages = [

    ClientHome(),
    ServiceProviderPost(),
    ClientFav(),
    ClientBookin(),




  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),

        ),


      home: Scaffold(

        
      bottomNavigationBar: BottomNavigationBar(

      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,

       currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              
            _currentIndex = index;
              
            });
          },


          items: [

            BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Home",

            ),


            BottomNavigationBarItem(icon: Icon(Icons.read_more),
            label: "post",

            ),



            BottomNavigationBarItem(icon: Icon(Icons.favorite),
            label: "Favorite",

            ),



            BottomNavigationBarItem(icon: Icon(Icons.book),
            label: "Hirring",

            ),


          
          ],



      ),

      body: _pages[_currentIndex],

      ),


    );




  }
}
