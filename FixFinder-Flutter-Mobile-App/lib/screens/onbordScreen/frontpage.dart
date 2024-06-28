


import 'package:checkfirebase/constants/colors.dart';
import 'package:flutter/material.dart';



class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     color: onboardingBackground,
    
       
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      
        children: [

            Text("Welcome",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),),
            Image.asset("assets/images/appicon.png", 
            width: 100,
             fit: BoxFit.cover,),
             const SizedBox(height: 20,),
             const Center(
              child: Text("FixFinder", style: TextStyle(fontSize: 40 , color:Colors.blue , fontWeight: FontWeight.bold),)
             )
               
        ],
      ),
    );
  }
}