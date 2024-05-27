import 'package:checkfirebase/constants/colors.dart';
import 'package:checkfirebase/constants/description.dart';
import 'package:checkfirebase/constants/styles.dart';
import 'package:checkfirebase/service/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //function

  final Function toggle;
  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();

  //form  key

  final _formKey = GlobalKey<FormState>();

  //email &  password store

  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgSolitude,
        appBar: AppBar(
          title: Text("Sign In"),
          elevation: 0,
          backgroundColor: bgSolitude,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text(
                  description,
                  style: descriptionStyle,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/appicon.png",
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //email
                        TextFormField(
                          decoration: textInputDecoration,
                          validator: (val) => val?.isEmpty == true
                              ? "Enter a valid Email"
                              : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        //password

                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: "password"),
                          validator: (val) =>
                              val!.length < 6 ? "Enter a valid password" : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        //google
                        const SizedBox(
                          height: 20,
                        ),
                        Text(error ,style: TextStyle(color: Colors.red),),
                        const Text(
                          "Login With Google Account",
                          style: descriptionStyle,
                        ),

                        GestureDetector(
                          //sign in with google

                          onTap: () {},

                          child: Center(
                            child: Image.asset(
                              "assets/images/google.png",
                              height: 70,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),
                        //register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do no have an account?",
                              style: descriptionStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                                //go to the rigister page
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(
                                    color: mainBlue,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),

                        //button
                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                          //method for login user

                          onTap: () async {
                            dynamic result = await _auth
                                .singInUsingEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                error =
                                    "user not sign in those emil and password";

                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: lightBlue,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(width: 5, color: mainBlue)),
                            child: const Center(child: Text("LOG IN")),
                          ),
                        ),

                        //anonymous

                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                          //method for login user

                          onTap: () async{

                             dynamic resulut = await _auth.signInAnonymously();

                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: lightBlue,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(width: 5, color: mainBlue)),
                            child: const Center(child: Text("LOG As GEUST")),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}





// ElevatedButton(
//         child: const Text("Sign Inn anonmously"),
//         onPressed: () async {
//           dynamic resulut = await _auth.signInAnonymously();

//           if (resulut == null) {
//             print("Error in sign in");
//           } else {
//             print("Sign in Anonymouslyy");
//             print(resulut.uid);
//           }
//         },
//       ),