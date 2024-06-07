import 'package:checkfirebase/models/UserModel.dart';
import 'package:checkfirebase/screen/authentication/authenticate.dart';
import 'package:checkfirebase/screen/home/home.dart';
import 'package:checkfirebase/screens/client/client_home.dart';
import 'package:checkfirebase/screens/client/client_main.dart';
//import 'package:checkfirebase/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return Authenticate();
    }else {
      return ClientMain();
    }
  }
}
