// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:giga_share/resources/image_resources.dart';
import 'package:giga_share/screens/home/history_screen.dart';
import 'package:giga_share/screens/home/home_screen.dart';
import 'package:giga_share/screens/home/paste_bin_screen.dart';
import 'package:giga_share/screens/home/profile_screen.dart';

import 'mint_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    HomeScreen(),
    PasteBinScreen(),
    MintingScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      body: pages[_page],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            selectedItemColor: ColorConstants.appColor,
            unselectedItemColor: Colors.black,
            onTap: onPageChanged,
            currentIndex: _page,
            type: BottomNavigationBarType.fixed,
            iconSize: 32,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageResources.homeIcon,
                  color: _page == 0 ? ColorConstants.appColor : Colors.black,
                  height: 30,
                  width: 30,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageResources.pasteBinIcon,
                  color: _page == 1 ? ColorConstants.appColor : Colors.black,
                  height: 30,
                  width: 30,
                ),
                label: 'Paste Bin',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageResources.mintingNFTIcon,
                  color: _page == 2 ? ColorConstants.appColor : Colors.black,
                  height: 30,
                  width: 30,
                ),
                label: 'Paste Bin',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageResources.historyIcon,
                  color: _page == 3 ? ColorConstants.appColor : Colors.black,
                  height: 30,
                  width: 30,
                ),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _page == 4 ? ColorConstants.appColor : Colors.black,
                ),
                label: 'Accounts',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
