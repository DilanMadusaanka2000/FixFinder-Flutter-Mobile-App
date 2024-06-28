import 'package:checkfirebase/constants/colors.dart';
import 'package:checkfirebase/constants/date.dart';
import 'package:flutter/material.dart';

class Progresscard2 extends StatefulWidget {
  const Progresscard2({super.key});

  @override
  State<Progresscard2> createState() => _Progresscard2State();
}

class _Progresscard2State extends State<Progresscard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200, // Increased height to accommodate images
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlueAccent, Colors.purpleAccent],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Free Register",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: kCardBackgroundColor,
              ),
            ),
            Text(
              "New Jobs are coming up soon",
              style: TextStyle(
                fontSize:18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
            //   children: [
            //     CircleAvatar(
            //       radius: 25,
            //       backgroundImage: AssetImage('assets/img/avatar1.jpeg'),
            //     ),
            //     CircleAvatar(
            //       radius: 25,
            //       backgroundImage: AssetImage('assets/img/avatar2.jpeg'), 
            //     ),
            //     CircleAvatar(
            //       radius: 25,
            //       backgroundImage: AssetImage('assets/img/avatar3.jpeg'), 
            //     ),
            //     CircleAvatar(
            //       radius: 25,
            //       backgroundImage: AssetImage('assets/img/avatar4.jpeg'), 
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
