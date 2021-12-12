import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final TextStyle textStyle;
  final void Function() function;

  const CustomButton({Key? key, required this.buttonColor, required this.textValue, required this.textStyle, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(20, 12, 20, 12)),
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: function,
      child: Text(
        textValue,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}