// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison

import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:giga_share/screens/auth/login_screen.dart';
import 'package:giga_share/screens/home/main_page.dart';
import 'package:giga_share/services/firebase_api.dart';
import 'package:giga_share/widgets/custom_button.dart';
import 'package:giga_share/widgets/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../resources/image_resources.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  File? _image;

  /*html_file.File? _webImage;*/
  Uint8List? _webBytes;
  UploadTask? task;
  String? urlDownload;

  void showSnackBar(String title) {
    final snackBar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ));
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  void registerUser() async {
    // Dialog box
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Registering you...',
      ),
    );

    final UserCredential user = await _auth
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .catchError((error) {
      Navigator.pop(context);
      PlatformException thisEx = error;
      showSnackBar(thisEx.message as String);
    });

    if (user != null) {
      DatabaseReference newUserReference =
          FirebaseDatabase.instance.ref().child('users/${_auth.currentUser!.uid}');

      // String uploadID = newUserReference.push().key!;

      final fileName = kIsWeb ? '${DateTime.now()}' : path.basename(_image.toString());
      final destination = 'files/$fileName';
      try {
        task = kIsWeb
            ? FirebaseApi.uploadBytes(destination, _webBytes!)
            : FirebaseApi.uploadFile(destination, _image!);
        setState(() {});

        if (task == null) return;

        final snapshot = await task!.whenComplete(() {});
        urlDownload = await snapshot.ref.getDownloadURL();
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }

      Map userMap = {
        'fullname': fullNameController.text,
        'email': emailController.text,
        'profileImage': urlDownload!,
      };

      newUserReference.set(userMap);

      Get.offAll(MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    ImageResources.appTextLogoImage,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Create Your Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.appColor,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          //late final selectedImage
                          late final File selectedImage;
                          if (kIsWeb) {
                            _webBytes = await image!.readAsBytes();
                            setState(() {
                              /*_webImage = html_file.File(_webBytes!, image.name);*/
                            });
                          } else {
                            setState(() {
                              _image = File(image!.path);
                            });
                          }
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(500),
                              border: Border.all(color: Colors.black54, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: (_image != null || _webBytes != null)
                                  ? kIsWeb
                                      ? Image.memory(_webBytes!)
                                      : Image.file(File(_image!.path))
                                  : Image.network(
                                      'https://publish.one37pm.net/wp-content/uploads/2022/03/IPFS-uni.png?fit=1600%2C707',
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                      title: 'REGISTER',
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
                        if (fullNameController.text.length < 3) {
                          showSnackBar('Please enter your full name');
                          return;
                        }

                        if (!emailController.text.contains('@')) {
                          showSnackBar('Please enter a valid email Address');
                          return;
                        }

                        if (passwordController.text.length <= 8) {
                          showSnackBar('Password must be at least 8 characters');
                          return;
                        }

                        if (kIsWeb) {
                          if (_webBytes == null) {
                            showSnackBar('Upload your images');
                            return;
                          }
                        } else {
                          if (_image == null) {
                            showSnackBar('Upload your images');
                            return;
                          }
                        }

                        registerUser();
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                onPressed: () {
                  Get.offAll(LoginScreen());
                },
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
