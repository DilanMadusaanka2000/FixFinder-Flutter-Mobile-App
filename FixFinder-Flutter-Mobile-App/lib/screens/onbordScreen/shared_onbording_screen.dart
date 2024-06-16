//import 'package:checkfirebase/constants/description.dart';
import 'package:flutter/material.dart';

class SharedOnbordingScreen extends StatelessWidget {
  final String title;
  final String imagePathe;
  final String appDescription;
  const SharedOnbordingScreen({super.key, required this.title, required this.imagePathe, required this.appDescription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
      
      
        children: [
         
         const SizedBox(height: 20,),
      
          Image.asset(imagePathe, width: 300, fit: BoxFit.contain,),
      
          const SizedBox(height:20 ,),
      
          Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700) ,),
      
      
      
           const SizedBox(height:20 ,),
      
          Text(appDescription, 
         style:  TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.grey) ,)
        ],
      ),
    );
  }
}
