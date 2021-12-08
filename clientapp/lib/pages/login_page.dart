import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterthree/class/fire_auth.dart';
import 'package:flutterthree/class/validator.dart';
import 'package:flutterthree/pages/profile_page.dart';

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
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
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
                        controller: _emailTextController,
                        validator: (value) => Validator.validateEmail(email: value!),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
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
                                    Navigator.of(context)
                                        .pushReplacement(
                                      MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              child: const Text(
                                'Register',
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