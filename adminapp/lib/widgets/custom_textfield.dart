import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController myController;
  final TextInputType myTextInputType;
  final String myHintText;
  final bool obscureText;
  final void Function(String)? onChangedFunction;
  final String errorText;

  const CustomTextField({Key? key, required this.myController, required this.myTextInputType, required this.myHintText, required this.obscureText, required this.onChangedFunction, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChangedFunction,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: myTextInputType,
      controller: myController,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: myHintText,
          errorText: errorText
      ),
    );
  }
}