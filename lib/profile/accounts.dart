// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison, unnecessary_cast, must_be_immutable,prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  String getUserName;
  String getUserEmail;
  String getUserImage;

  Accounts({
    Key? key,
    required this.getUserName,
    required this.getUserEmail,
    required this.getUserImage,
  }) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  File? _image;

  void showSnackBar(String title) {
    final snackBar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ));
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "Your Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontFamily: 'Brand-Bold',
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(500),
                            border: Border.all(color: Colors.black54, width: 2),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _image != null
                                  ? FileImage(File(_image!.path))
                                  : NetworkImage(
                                      widget.getUserImage,
                                    ) as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(widget.getUserName),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(widget.getUserEmail),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Files Uploaded on IPFS',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Text('0'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
