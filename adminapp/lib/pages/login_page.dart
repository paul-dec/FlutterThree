import 'package:adminapp/class/fire_auth.dart';
import 'package:adminapp/class/validator.dart';
import 'package:adminapp/pages/main_page.dart';
import 'package:adminapp/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        title: const Text('Firebase Authentication', style: ThemeText.whiteTextBold,),
        backgroundColor: ThemeColor.xPurple,
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: ThemeText.whiteText,
                        controller: _emailTextController,
                        validator: (value) => Validator.validateEmail(email: value!),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        style: ThemeText.whiteText,
                        controller: _passwordTextController,
                        obscureText: true,
                        validator: (value) => Validator.validatePassword(password: value!),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User? user = await FireAuth.signInUsingEmailPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text, context: context,
                                  );
                                  if (user != null) {
                                    var adminchecker = 'user';
                                    await FirebaseFirestore.instance.collection("users").get().then(
                                      (value) {
                                        for (var element in value.docs) {
                                          if (element.id == user.uid) {
                                            adminchecker = element.data()['role'];
                                          }
                                        }
                                      },
                                    );
                                    var z = <Map>[];

                                    // await FirebaseFirestore.instance.collection("users").get().then(
                                    //       (value) {
                                    //     for (var element in value.docs) {
                                    //       var userDetails = {};
                                    //       userDetails['id'] = element.id;
                                    //       userDetails['name'] = element.data()['name'];
                                    //       userDetails['role'] = element.data()['role'];
                                    //       userDetails['NFT'] = element.data()['NFT'];
                                    //       z.add(userDetails);
                                    //     }
                                    //   },
                                    // );
                                    if (adminchecker == 'admin' || adminchecker == 'manager') {
                                      final String roleChecker = adminchecker;
                                      Navigator.of(context)
                                          .pushReplacement(
                                        MaterialPageRoute(builder: (context) => MainPage(user: user, role: roleChecker)),
                                      );
                                    } else {
                                      // error simple user does not have access to admin dashboard
                                    }
                                  }
                                }
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}