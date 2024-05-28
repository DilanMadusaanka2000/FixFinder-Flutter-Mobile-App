import 'package:checkfirebase/constants/colors.dart';
import 'package:checkfirebase/constants/date.dart';
import 'package:flutter/material.dart';

class Progresscard extends StatefulWidget {
  const Progresscard({super.key});

  @override
  State<Progresscard> createState() => _ProgresscardState();
}

class _ProgresscardState extends State<Progresscard> {
  //final String date = formattedDate;
  // String day = formatterDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kGradientTopColor, kGradientBottomColor],
        ),
      ),


      child: const Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Get Your  Solution &\nJobs in One Place",
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: kCardBackgroundColor),
            ),
            SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              backgroundColor: kMainWhiteColor,
              valueColor: AlwaysStoppedAnimation(kMainWhiteColor),
             // borderRadius: BorderRadius.circular(100),
            ),
            // Text(
            //   " date day ",
            //   style: TextStyle(
            //       fontSize: 10,
            //       fontWeight: FontWeight.w200,
            //       color: kCardBackgroundColor),
            // ),
          ],
        ),
      ),
    );
  }
}
