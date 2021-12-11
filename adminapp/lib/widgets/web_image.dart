import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WebImage extends StatelessWidget {

  final String url;

  const WebImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(10),
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Image.network(
            url,
            fit: BoxFit.fill,
          )
      ),
    );
  }
}