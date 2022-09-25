// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables, unnecessary_null_comparison, unnecessary_cast, unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giga_share/models/user_model.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:giga_share/screens/home/history_screen.dart';
import 'package:giga_share/upload/receive_screen.dart';
import 'package:giga_share/upload/upload_screen.dart';
import 'package:giga_share/widgets/boxes.dart';
import 'package:giga_share/widgets/custom_home_button.dart';
import 'package:giga_share/widgets/history_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.appColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Box Share',
          style: TextStyle(
            letterSpacing: 1.2,
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomHomeButton(
                        icon: Icons.upload_file_rounded,
                        text: 'Upload',
                        onPressed: () {
                          Get.to(() => UploadScreen());
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    kIsWeb
                        ? SizedBox.shrink()
                        : Expanded(
                            child: CustomHomeButton(
                              icon: Icons.get_app,
                              text: 'Receive',
                              onPressed: () {
                                Get.to(() => ReceiveScreen());
                              },
                            ),
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomHomeButton(
                        icon: Icons.share,
                        text: 'Invite',
                        onPressed: () {
                          Share.share(
                              'Download our application Box Share from the below link https://drive.google.com/drive/u/0/folders/1--lL9ObgQoVzc0zH7ezsM4U12e8-WRHK');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 5,
                bottom: 15,
                right: 10,
              ),
              child: Row(
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      Get.to(() => HistoryScreen());
                    },
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<Box<UserModel>>(
              valueListenable: Boxes.getTransactions().listenable(),
              builder: (context, box, _) {
                final transactions = box.values.toList().cast<UserModel>();
                return Expanded(
                  child: HistoryCard(
                    transactions: transactions,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
