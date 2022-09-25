// ignore_for_file: prefer_const_constructors, await_only_futures, unnecessary_cast, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giga_share/profile/about.dart';
import 'package:giga_share/profile/accounts.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:giga_share/screens/auth/login_screen.dart';
import 'package:giga_share/widgets/custom_profile_tile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wiredash/wiredash.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getUserName = '';
  String getUserEmail = '';
  String getUserImage = '';
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    DatabaseReference userReference =
        FirebaseDatabase.instance.ref().child('users/${_auth.currentUser!.uid}');

    final user = userReference.once().then((DatabaseEvent databaseEvent) {
      final value = databaseEvent.snapshot.value;

      setState(() {
        getUserName = (value as Map)['fullname'].toString();
        getUserImage = (value as Map)['profileImage'].toString();
        getUserEmail = (value as Map)['email'].toString();
      });

      loaded = true;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.appColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'PROFILE',
          style: TextStyle(
            letterSpacing: 1.2,
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: [
                (loaded == false)
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: ColorConstants.appColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              getUserImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          getUserName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            getUserEmail,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                CustomProfileTile(
                  icon: Icons.person_pin,
                  text: 'Account',
                  onPressed: () {
                    Get.to(() => Accounts(
                          getUserName: getUserName,
                          getUserEmail: getUserEmail,
                          getUserImage: getUserImage,
                        ));
                  },
                ),
                CustomProfileTile(
                  icon: Icons.person_add,
                  text: 'Invite a Friend',
                  onPressed: () {
                    Share.share(
                        'Download our application Giga Share from the below link https://github.com/Priyammm05/Giga-Share');
                  },
                ),
                CustomProfileTile(
                  icon: Icons.feedback,
                  text: 'Feedback',
                  onPressed: () => Wiredash.of(context).show(),
                ),
                CustomProfileTile(
                  icon: Icons.info,
                  text: 'About',
                  onPressed: () {
                    Get.to(() => About());
                  },
                ),
                CustomProfileTile(
                  icon: Icons.exit_to_app,
                  text: 'Logout',
                  onPressed: () async {
                    await _auth.signOut();
                    Get.offUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
