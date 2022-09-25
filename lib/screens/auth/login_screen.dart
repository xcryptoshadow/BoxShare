// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giga_share/resources/image_resources.dart';
import 'package:giga_share/screens/auth/signup_screen.dart';
import 'package:giga_share/screens/home/main_page.dart';
import 'package:giga_share/widgets/custom_button.dart';
import 'package:giga_share/widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void showSnackBar(String title) {
    final snackBar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ));
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  void login() async {
    // Dialog box
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Signing you in',
      ),
    );

    final UserCredential user = await _auth
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .catchError((error) {
      Navigator.pop(context);
      debugPrint("the error is :$error");
      /* try {
        PlatformException thisEx = error;
      } catch (e) {
        print(e);
        showSnackBar(" $e");
      }*/
    });

    if (user != null) {
      DatabaseReference userReference =
          FirebaseDatabase.instance.ref().child('users/${user.user!.uid}');

      userReference.once().then(
            (snapshot) => {
              if (snapshot != null)
                {
                  Get.offAll(() => MainPage()),
                }
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Image.asset(ImageResources.loginImage)),
              Text(
                'SIGN IN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      title: 'LOGIN',
                      color: Colors.blueAccent,
                      onPressed: () async {
                        // Network checking
                        var connectivityResult = await Connectivity().checkConnectivity();
                        if (connectivityResult != ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          showSnackBar('No Internet connection');
                          return;
                        }

                        // Textfield validation
                        if (!emailController.text.contains('@')) {
                          showSnackBar('Please enter a valid email Address');
                          return;
                        }

                        if (passwordController.text.length <= 8) {
                          showSnackBar('Password must be at least 8 characters');
                          return;
                        }

                        login();
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                onPressed: () {
                  Get.to(() => SignupScreen());
                },
                child: Text("Don't have an account, sign-up here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
