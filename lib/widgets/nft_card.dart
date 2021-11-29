import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NFTCard extends StatelessWidget {

  final String url;
  final String name;
  final String description;

  const NFTCard({Key? key, required this.url, required this.name, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(10),
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Hero(
            tag: name,
            child: Image.network(
              url,
              fit: BoxFit.fill,
            ),
          )
      ),
    );
  }
}