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
        // appBar: AppBar(
        //   title: Center(child: Text("Sign In",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
        //   elevation: 0,
        //   backgroundColor: bgSolitude,
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // const Text(
                //   description,
                //   style: descriptionStyle,  textAlign: TextAlign.center,

                // ),
                SizedBox(height: 10,),
                Center(
                  child: Image.asset(
                    "assets/images/appicon.png",
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(child: Text("Wellcome Back",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black,),),
                ),
                Center(child: Text("Sign in to continue",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)),
                SizedBox(height: 30,),
                Container(

                  // color: Colors.blue,

                  child: Container(
                    child: Padding(
                      
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
                             SizedBox(height: 10,),
                    
                    
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
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(width: 5, color: Colors.blue)),
                                child: const Center(child: Text("LOG IN",style: TextStyle(color: Colors.white),)),
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
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(width: 5, color: Colors.blue)),
                                child: const Center(child: Text("Log as geust", style: TextStyle(color:Colors.white),)),
                              ),
                            ),
                          ],
                        ),
                      ),
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