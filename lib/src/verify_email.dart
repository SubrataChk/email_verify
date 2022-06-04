import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:email_verify/src/home.dart';
import 'package:email_verify/src/login.dart';
import 'package:email_verify/src/widget/warning.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'global/global.dart';

class EmailVerification extends StatefulWidget {
  final TextEditingController? email;
  const EmailVerification({Key? key, this.email}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendEmail();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        checkMailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkMailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      showMessage("Verification email send");
    } catch (e) {
      showMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomePage()
        : Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextFormField(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 16.w,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueAccent),
                        child: Text(
                          "Resend",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        firebaseAuth.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        // sendOtp();
                      },
                      child: Text("Log Out")),
                ],
              ),
            ),
          );
  }
}
