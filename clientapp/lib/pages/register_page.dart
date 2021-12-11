import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterthree/BLoC/bloc.dart';
import 'package:flutterthree/class/fire_auth.dart';
import 'package:flutterthree/widgets/custom_button.dart';
import 'package:flutterthree/widgets/custom_spacer.dart';
import 'package:flutterthree/widgets/custom_textfield.dart';

import '../styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();

  String errorString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        backgroundColor: ThemeColor.xPurple,
        title: const Text("Register", style: ThemeText.whiteTextBold,),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: bloc.name,
                builder: (context, snapshot) {
                  return CustomTextField(
                    myController: pseudoController,
                    myTextInputType: TextInputType.name,
                    myHintText: 'Your name',
                    obscureText: false,
                    onChangedFunction: bloc.changeName,
                    errorText: snapshot.error.toString() == 'null' ? '' : snapshot.error.toString(),
                  );
                },
              ),
              const CustomSpacer(),
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
                textValue: 'Register',
                textStyle: ThemeText.whiteTextBold,
                function: () async {
                  postRegister();
                },
              ),
              const CustomSpacer(),
              Text(errorString, style: ThemeText.xPurpleTextItalic,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postRegister() async {
    var result = FirebaseFirestore.instance.collection("users");
    User? user = await FireAuth.registerUsingEmailPassword(
      email: emailController.text,
      password: passwordController.text,
      name: pseudoController.text,
    );
    if (user != null) {
      result.doc(user.uid).set({"role": "user", "name": pseudoController.text, "NFT": []}).then((value) => Navigator.of(context).pop());
    }
  }
}