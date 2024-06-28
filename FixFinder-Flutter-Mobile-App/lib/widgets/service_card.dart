import 'package:checkfirebase/constants/colors.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String description;
  const ServiceCard({super.key, required this.title, required this.imgUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
     width: MediaQuery.of(context).size.width *0.46,
      height: 150,
     // width: 250,
   

      decoration: BoxDecoration(
        color:cardColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(31, 75, 130, 212),
          offset: Offset(0, 5),
          blurRadius: 2,
        )
      ]
      
      
      ),
     
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          children: [
        
          const SizedBox(height: 5,),
        
        
            Text(
              title,
              style:const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5,),
            Image.asset(imgUrl, width: 50,
            fit: BoxFit.cover,
            ),
            const SizedBox(height: 5,),


            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),


          ],
        ),
      ),


    );
  }
}
