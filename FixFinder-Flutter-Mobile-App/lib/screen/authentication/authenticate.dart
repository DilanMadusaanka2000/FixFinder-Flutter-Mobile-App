//import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool singinPage = true;

  //toggle page

  void switchPage() {
    setState(() {
      singinPage = !singinPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  return SignIn();

    if (singinPage == true) {
      return SignIn(toggle: switchPage);
    } else {
      return Register(toggle: switchPage);
    }
  }
}
