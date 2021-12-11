import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterthree/BLoC/bloc.dart';
import 'package:flutterthree/functions/uploadImage.dart';
import 'package:flutterthree/widgets/custom_button.dart';
import 'package:flutterthree/widgets/custom_spacer.dart';
import 'package:flutterthree/widgets/custom_textfield.dart';

import '../styles.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key, required this.uid}) : super(key: key);
  
  final String uid;

  @override
  State<UploadPage> createState() => _UploadPageState(uid: uid);
}

class _UploadPageState extends State<UploadPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final String uid;

  String errorString = "";

  _UploadPageState({required this.uid});

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
                    myController: nameController,
                    myTextInputType: TextInputType.name,
                    myHintText: 'Name of the NFT',
                    obscureText: false,
                    onChangedFunction: bloc.changeName,
                    errorText: snapshot.error.toString() == 'null' ? '' : snapshot.error.toString(),
                  );
                },
              ),
              const CustomSpacer(),
              StreamBuilder(
                stream: bloc.description,
                builder: (context, snapshot) {
                  return CustomTextField(
                    myController: descriptionController,
                    myTextInputType: TextInputType.emailAddress,
                    myHintText: 'Description of the NFT',
                    obscureText: false,
                    onChangedFunction: bloc.changeDescription,
                    errorText: snapshot.error.toString() == 'null' ? '' : snapshot.error.toString(),
                  );
                },
              ),
              const CustomSpacer(),
              CustomButton(
                buttonColor: ThemeColor.xPurple,
                textValue: 'Select file and upload',
                textStyle: ThemeText.whiteTextBold,
                function: () async {
                  postNFT();
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

  Future<void> postNFT() async {
    if (nameController.text.isEmpty || descriptionController.text.isEmpty) return;
    String link = await uploadImage();
    print(link);
    var result = await FirebaseFirestore.instance.collection("users").doc(uid);
    result.update({
      "NFT": FieldValue.arrayUnion([{"name": nameController.text, "image": link, "desc": descriptionController.text}])
    }).then((value) => Navigator.of(context).pop(true));
  }
}