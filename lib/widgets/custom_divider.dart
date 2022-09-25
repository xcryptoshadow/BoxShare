// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Divider(
        height: 1,
        color: Colors.black26,
        thickness: 1,
      ),
    );
  }
}
