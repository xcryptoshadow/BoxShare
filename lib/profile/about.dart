// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:giga_share/resources/image_resources.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.appColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Image.asset(ImageResources.ipfsImage, fit: BoxFit.cover),
                ),
                SizedBox(height: 8),
                Text(
                  'version - 1.0.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              title: Text(
                'Introduction',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Text(
                    '''
Box Share is an mobile application that uploads the content to IPFS and generates decentralized QR codes. It is compatible with any android phones. Built by BUIDL Tools.
      ''',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            ExpansionTile(
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              title: Text(
                'Benefits',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Text(
                    '''
Box Share allows you to quickly upload images/videos or files to IPFS by using web3 storage and get a "decentralized QR code" with IPFS CID. Later you can share the QR code or hosted gateway link with everyone for easy and decentralized file sharing.
      
Benefits of Box Share for file sharing:
  • Decentralized storage
  • Unlimited uploads
  • Fast upload speed
  • Zero compression
  • Private
  • Free to use
  • User-friendly
''',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
