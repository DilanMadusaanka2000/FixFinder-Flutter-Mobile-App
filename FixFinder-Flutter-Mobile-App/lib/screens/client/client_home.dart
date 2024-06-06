import 'package:checkfirebase/constants/colors.dart';
import 'package:checkfirebase/constants/date.dart';
import 'package:checkfirebase/constants/responsive.dart';
import 'package:checkfirebase/screens/client/card/electrician.dart';
import 'package:checkfirebase/screens/client/card/carpenter.dart';
import 'package:checkfirebase/screens/client/card/gardning_mentainer.dart';
import 'package:checkfirebase/screens/client/card/plumber.dart';
import 'package:checkfirebase/screens/client/card/meason.dart';
import 'package:checkfirebase/screens/request/client_request.dart';
import 'package:checkfirebase/screens/serviceProvider/serviceProvider_profile.dart';
import 'package:checkfirebase/service/check_Employer_hasData.dart';
import 'package:checkfirebase/widgets/progressCard.dart';
import 'package:checkfirebase/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {

  //want get user name using shared prefference

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
   
       child: Padding(
         padding: const EdgeInsets.all(kDefaultPadding),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         
          children: [
            Text(
              "$formattedDate $formatterDay" , 
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kSubtitleColor),
              ),

                Text(
              "Hello, Dilan" , 
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: kMainColor),
              ),


              //button navigate profile 
                 ElevatedButton(
                      onPressed: () {
                              
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CheckEmployeeData()), // Navigate to the new screen
                                   );
                                        },
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Change Account'),
                    ),
                  
                     //check req send data to the db 

                    //  ElevatedButton(
                    //   onPressed: () {
                              
                    //           Navigator.push(
                    //           context,
                    //           MaterialPageRoute(builder: (context) => ClientRequest()), // Navigate to the new screen
                    //                );
                    //                     },
                    //   style: ElevatedButton.styleFrom(
                    //     iconColor: Colors.purple,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //   ),
                    //   child: Text('Request Service'),
                    // ),





              const SizedBox(height:20),
              Progresscard(),

              const SizedBox(height: 20,
              ),

              Text(" Today's Service",style: TextStyle(fontSize: 18, 
              fontWeight: FontWeight.bold), ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                     onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Electrician()),
                      ),
                    child: ServiceCard(
                      description: "See Service Providers",
                      imgUrl: "assets/img/electrician.png",
                      title: "Electrician",
                    ),
                  ),


      //plumber


                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Plumber())
                    ),
                    child: ServiceCard(
                      description: "See Service Providers",
                      imgUrl: "assets/img/electrician.png",
                      title: "Plumber",
                    ),
                  ),

                 

                  
                ],
              ),
              const SizedBox(height: 20,),


              //second row
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  GestureDetector(
                    onTap:() => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GardningMentainer())
                    ),

                    child: ServiceCard(
                      description: "See Service Providers",
                      imgUrl: "assets/img/electrician.png",
                      title: "Gardning",
                    ),
                  ),

                  GestureDetector(

                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Carpenter())
                    ),
                    child: ServiceCard(
                      description: "See Service Providers",
                      imgUrl: "assets/img/electrician.png",
                      title: "Carpenter",
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 20,),
                  

            
            ],
         ),
       ),


        ),
        
      ),
    );
  }
}