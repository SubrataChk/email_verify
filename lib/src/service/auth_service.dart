import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../global/global.dart';
import '../home.dart';
import '../login.dart';
import '../verify_email.dart';
import '../widget/warning.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(AuthProvider.pattern.toString());

  userSignUp(
      {required TextEditingController? name,
      required TextEditingController? email,
      required TextEditingController? password,
      required BuildContext context}) async {
    if (name!.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Name is empty!");
      return;
    } else if (email!.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Email address is empty");
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      isLoading = false;
      notifyListeners();
      showMessage("Please enter a valid email address");
      return;
    } else if (password!.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Password is empty");
      return;
    } else if (password.text.length <= 7) {
      isLoading = false;
      notifyListeners();
      showMessage("Password must be 8 character or number");
      return;
    } else {
      try {
        isLoading = true;
        notifyListeners();
        final User? firebaseUser = (await firebaseAuth
                .createUserWithEmailAndPassword(
                    email: email.text.trim(), password: password.text.trim())
                .catchError((error) {
          showMessage("Error: " + error.toString());
        }))
            .user;

        if (firebaseUser != null) {
          //Save user Data

          Map<String, dynamic> userDataMap = {
            "name": name.text.trim(),
            "email": email.text.trim(),
            "uid": firebaseUser.uid,
          };

          users.doc(firebaseUser.uid).set(userDataMap);

          //locally Data save:

          isLoading = false;
          notifyListeners();
          if (firebaseAuth.currentUser!.emailVerified) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
            //Verified
          } else {
            firebaseUser.sendEmailVerification();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmailVerification(
                          email: email,
                        )));
          }
          // ignore: use_build_context_synchronously

          showMessage("Congratulation, your account has been created");
        } else {
          //Error
          showMessage("Account has not been created");
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        notifyListeners();
        if (e.code == 'weak-password') {
          isLoading = false;
          notifyListeners();
          showMessage("The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          isLoading = false;
          notifyListeners();
          isLoading = false;
          notifyListeners();
          showMessage("The account already exists for that email.");
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();
        showMessage(e.toString());
      }
    }
  }

  userLogIn(
      {required TextEditingController? email,
      required TextEditingController? password,
      required BuildContext context}) async {
    if (email!.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Email address is empty");
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      isLoading = false;
      notifyListeners();
      showMessage("Please enter a valid email address");
      return;
    } else if (password!.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Password is empty");
      return;
    } else {
      try {
        isLoading = true;
        notifyListeners();
        final User? firebaseUser =
            (await firebaseAuth.signInWithEmailAndPassword(
                    email: email.text.trim(), password: password.text.trim()))
                .user;

        if (firebaseUser != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseUser.uid)
              .get()
              .then((snap) async {
            if (snap.exists) {
              isLoading = false;
              notifyListeners();
              Navigator.pop(context);

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
              showMessage("Welcome back Sir!");
            } else {
              firebaseAuth.signOut();
              isLoading = false;
              notifyListeners();

              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              showMessage("No record found Sir");
            }
          });
        }
      } on FirebaseException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading = false;
          notifyListeners();
          showMessage("No user found for that email.");
        } else if (e.code == 'wrong-password') {
          isLoading = false;
          notifyListeners();
          showMessage("Wrong password");
        }
      } catch (e) {
        showMessage(e.toString());
      }
    }

    //Doctor Data:
  }
}
