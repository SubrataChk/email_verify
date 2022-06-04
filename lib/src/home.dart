import 'package:email_verify/src/widget/customButton.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'global/global.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Home Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          )),
          CustomButton(
              backColors: Colors.blueGrey,
              onTap: () async {
                await firebaseAuth.signOut();
              },
              title: "Log Out")
        ],
      )),
    );
  }
}
