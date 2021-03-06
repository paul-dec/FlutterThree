import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterthree/BLoC/bloc.dart';
import 'package:flutterthree/class/fire_auth.dart';
import 'package:flutterthree/pages/profile_page.dart';
import 'package:flutterthree/pages/register_page.dart';
import 'package:flutterthree/styles.dart';
import 'package:flutterthree/widgets/custom_button.dart';
import 'package:flutterthree/widgets/custom_spacer.dart';
import 'package:flutterthree/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        backgroundColor: ThemeColor.xPurple,
        title: const Text("Login", style: ThemeText.whiteTextBold,),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: bloc.email,
                builder: (context, snapshot) {
                  return CustomTextField(
                    myController: emailController,
                    myTextInputType: TextInputType.emailAddress,
                    myHintText: 'Your email',
                    obscureText: false,
                    onChangedFunction: bloc.changeEmail,
                    errorText: snapshot.error.toString() == 'null' ? '' : snapshot.error.toString(),
                  );
                },
              ),
              const CustomSpacer(),
              StreamBuilder(
                stream: bloc.password,
                builder: (context, snapshot) {
                  return CustomTextField(
                    myController: passwordController,
                    myTextInputType: TextInputType.visiblePassword,
                    myHintText: 'Your password',
                    obscureText: true,
                    onChangedFunction: bloc.changePassword,
                    errorText: snapshot.error.toString() == 'null' ? '' : snapshot.error.toString(),
                  );
                },
              ),
              const CustomSpacer(),
              CustomButton(
                buttonColor: ThemeColor.xPurple,
                textValue: 'Sign In',
                textStyle: ThemeText.whiteTextBold,
                function: () async {
                  postLogin(emailController.text, passwordController.text, context);
                },
              ),
              const CustomSpacer(),
              CustomButton(
                buttonColor: Colors.transparent,
                textValue: 'Register',
                textStyle: ThemeText.whiteTextItalic,
                function: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
              ),
              const CustomSpacer(),
              Text(errorString.replaceAll("Exception:", ""), style: ThemeText.xPurpleTextItalic,)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postLogin(email, password, context) async {
    User? user = await FireAuth.signInUsingEmailPassword(
      email: email,
      password: password,
      context: context,
    );
    if (user != null) {
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
      );
    }
  }
}