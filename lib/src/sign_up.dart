import 'package:email_auth/email_auth.dart';
import 'package:email_verify/src/service/auth_service.dart';
import 'package:email_verify/src/widget/customButton.dart';
import 'package:email_verify/src/widget/text_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
 
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  "Create New Account",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
              ),
              CustomTextFormField(
                title: "Name",
                icons: CupertinoIcons.person,
                controller: name,
              ),
              CustomTextFormField(
                title: "Email",
                icons: CupertinoIcons.mail,
                controller: email,
              ),
              CustomTextFormField(
                title: "Password",
                icons: Icons.vpn_key,
                controller: password,
              ),
              authProvider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.red),
                    )
                  : CustomButton(
                      backColors: Colors.blueAccent,
                      title: "Create",
                      onTap: () {
                        authProvider.userSignUp(
                            name: name,
                            email: email,
                            password: password,
                            context: context);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
