import 'package:adminapp/BLoC/bloc.dart';
import 'package:adminapp/class/fire_auth.dart';
import 'package:adminapp/pages/main_page.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/custom_button.dart';
import 'package:adminapp/widgets/custom_spacer.dart';
import 'package:adminapp/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  String errorString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        title: const Text('Firebase Authentication', style: ThemeText.whiteTextBold,),
        backgroundColor: ThemeColor.xPurple,
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
                    myController: _emailTextController,
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
                    myController: _passwordTextController,
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
                  postLogin(context);
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

  postLogin(context) async {
    try {
      User? user = await FireAuth.signInUsingEmailPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        context: context,
      );
      if (user != null) {
        var adminChecker = 'user';
        await FirebaseFirestore.instance.collection("users").get().then((
            value) {
          for (var element in value.docs) {
            if (element.id == user.uid) {
              adminChecker = element.data()['role'];
            }
          }
        },);
        if (adminChecker == 'admin' || adminChecker == 'manager') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => MainPage(user: user, role: adminChecker)),
          );
        } else {
          setState(() {
            errorString = "You don't have access";
          });
        }
      } else {
        setState(() {
          errorString = "Email or password incorrect";
        });
      }
    } catch(e) {
      setState(() {
        errorString = "Internet error";
      });
    }
  }
}