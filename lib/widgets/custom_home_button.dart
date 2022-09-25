// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:giga_share/resources/color_constants.dart';

class CustomHomeButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData icon;

  const CustomHomeButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              /*gradient: LinearGradient(
                colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),*/
            ),
            child: Center(
              child: Icon(
                icon,
                color: ColorConstants.messageErrorBgColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
