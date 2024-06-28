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
import 'package:checkfirebase/widgets/progrescard2.dart';
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
                  "$formattedDate $formatterDay",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kSubtitleColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "FIXFinder",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: kMainColor),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CheckEmployeeData()), // Navigate to the new screen
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 4, 4, 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Change Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Progresscard(),
                const SizedBox(height: 20),
                Text(
                  "Contact Now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                
                  child: Row(
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
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Plumber()),
                        ),
                        child: ServiceCard(
                          description: "See Service Providers",
                          imgUrl: "assets/img/plumber.png",
                          title: "Plumber",
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GardningMentainer()),
                        ),
                        child: ServiceCard(
                          description: "See Service Providers",
                          imgUrl: "assets/img/gardning.png",
                          title: "Gardning",
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Carpenter()),
                        ),
                        child: ServiceCard(
                          description: "See Service Providers",
                          imgUrl: "assets/img/carpenter.png",
                          title: "Carpenter",
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Progresscard2(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
