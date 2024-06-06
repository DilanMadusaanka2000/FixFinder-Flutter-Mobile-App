import 'dart:ffi';

import 'package:checkfirebase/models/UserModel.dart';
import 'package:checkfirebase/screen/authentication/authenticate.dart';
import 'package:checkfirebase/screen/authentication/register.dart';
import 'package:checkfirebase/screen/authentication/sign_in.dart';
import 'package:checkfirebase/screen/wrapper.dart';
import 'package:checkfirebase/screens/client/client_main.dart';
import 'package:checkfirebase/screens/request/client_request.dart';
import 'package:checkfirebase/service/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//import 'screen/home/homeScreen.dart';
import 'package:checkfirebase/pages/addpage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //await Firebase.initializeApp();

// await Firebase.initializeApp(
//     options:const FirebaseOptions(
//       apiKey: "AIzaSyAIzXp60lfynT8509KbE3DpQIiscpwX2ag",
//       appId: "1:714592404471:android:6ff3febc8ffcaef5f424f2",
//       messagingSenderId: "714592404471",
//       projectId: "checkfirebase-f3ddc",
//     ),
//   );

//   runApp(const MyApp());
// }

//firebase initialization

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAIzXp60lfynT8509KbE3DpQIiscpwX2ag",
      appId: "1:714592404471:android:6ff3febc8ffcaef5f424f2",
      messagingSenderId: "714592404471",
      projectId: "checkfirebase-f3ddc",
      storageBucket: "gs://checkfirebase-f3ddc.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: UserModel(uid: ""),
      value: AuthServices().user,
      child: MaterialApp(

        theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),

        ),
        debugShowCheckedModeBanner: false,
         home: Wrapper(),


         // home: ClientRequest(),



       // home:  ClientMain(),

        // home:ScaleTransitionExampleApp(),
         //home: HomePage(),
      // home: AddPage(),
      
       //home:Authenticate(),
       //home:Register();

       // home:AddPage(),
      ),
    );
  }
}
