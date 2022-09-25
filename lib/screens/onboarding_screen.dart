// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, avoid_print, must_be_immutable, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giga_share/models/data/data.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:giga_share/screens/auth/login_screen.dart';

import 'home/main_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<SliderModel> mySLides = <SliderModel>[];
  int slideIndex = 0;
  PageController? controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    debugPrint('the current page is : $isCurrentPage');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mySLides = getSlides();
    controller = PageController();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Get.offAll(() => MainPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            /*height: MediaQuery.of(context).size.height - 100,*/
            child: Container(
              color: Colors.white.withOpacity(0.2),
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[
                  SlideTile(
                    imagePath: mySLides[0].getImageAssetPath(),
                    title: mySLides[0].getTitle(),
                    desc: mySLides[0].getDesc(),
                  ),
                  SlideTile(
                    imagePath: mySLides[1].getImageAssetPath(),
                    title: mySLides[1].getTitle(),
                    desc: mySLides[1].getDesc(),
                  ),
                  SlideTile(
                    imagePath: mySLides[2].getImageAssetPath(),
                    title: mySLides[2].getTitle(),
                    desc: mySLides[2].getDesc(),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            child: Container(
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    i == slideIndex ? _buildPageIndicator(true) : _buildPageIndicator(false),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: slideIndex != 2
          ? Container(
              color: ColorConstants.appColor,
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        controller!.animateToPage(2,
                            duration: Duration(milliseconds: 400), curve: Curves.linear);
                      },
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                          color: ColorConstants.appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        print("this is slideIndex: $slideIndex");
                        controller!.animateToPage(slideIndex + 1,
                            duration: Duration(milliseconds: 500), curve: Curves.linear);
                      },
                      child: Text(
                        "NEXT",
                        style:
                            TextStyle(color: ColorConstants.appColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                Get.to(() => LoginScreen());
              },
              child: Container(
                height: 70,
                color: ColorConstants.messageErrorBgColor,
                alignment: Alignment.center,
                child: Text(
                  "GET STARTED NOW",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String? imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Image.asset(
              imagePath!,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(desc!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16))
        ],
      ),
    );
  }
}
