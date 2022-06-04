import 'package:email_verify/src/service/auth_service.dart';
import 'package:email_verify/src/sign_up.dart';
import 'package:email_verify/src/widget/customButton.dart';
import 'package:email_verify/src/widget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              // Lottie.asset("assets/login.json"),
              SizedBox(
                height: 20.h,
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
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      backColors: Colors.blueAccent,
                      title: "Log In",
                      onTap: () {
                        authProvider.userLogIn(
                            email: email, password: password, context: context);
                      },
                    ),
              Text(
                "&",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              CustomButton(
                backColors: Colors.green,
                title: "Sign Up",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
