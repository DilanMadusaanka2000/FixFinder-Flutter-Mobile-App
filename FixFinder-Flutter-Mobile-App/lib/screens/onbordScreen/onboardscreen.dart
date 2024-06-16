import 'package:checkfirebase/data/onboarding_data.dart';
import 'package:checkfirebase/screen/authentication/authenticate.dart';
import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/sign_in.dart';
import 'package:checkfirebase/screen/wrapper.dart';
import 'package:checkfirebase/screens/onbordScreen/frontpage.dart';
import 'package:checkfirebase/screens/onbordScreen/shared_onbording_screen.dart';
//import 'package:checkfirebase/screens/register_screen.dart'; // Import the Register screen
import 'package:checkfirebase/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnordingScreen extends StatefulWidget {
  const OnordingScreen({super.key});

  @override
  State<OnordingScreen> createState() => _OnordingScreenState();
}

class _OnordingScreenState extends State<OnordingScreen> {
  // Page controller
  final PageController _controller = PageController();
  bool showHomePage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showHomePage = index == 3;
                      print('Page changed to $index, showHomePage: $showHomePage');
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnbordingScreen(
                      title: OnbordingData.onbordingDatalist[0].title,
                      imagePathe: OnbordingData.onbordingDatalist[0].imagePathe,
                      appDescription: OnbordingData.onbordingDatalist[0].appDescription,
                    ),
                    SharedOnbordingScreen(
                      title: OnbordingData.onbordingDatalist[1].title,
                      imagePathe: OnbordingData.onbordingDatalist[1].imagePathe,
                      appDescription: OnbordingData.onbordingDatalist[1].appDescription,
                    ),
                    SharedOnbordingScreen(
                      title: OnbordingData.onbordingDatalist[2].title,
                      imagePathe: OnbordingData.onbordingDatalist[2].imagePathe,
                      appDescription: OnbordingData.onbordingDatalist[2].appDescription,
                    ),
                  ],
                ),
                Container(
                  alignment: const Alignment(0, 0.50),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                    ),
                  ),
                ),

                // Button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () {
                        if (showHomePage) {
                          // Navigate to Register screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Authenticate()),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      child: CustomButton(
                        buttonName: showHomePage ? "Get Started" : "Next",
                        buttonColor: Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
