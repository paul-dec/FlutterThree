import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class NFTDetails extends StatefulWidget {
  final String name;
  final String url;
  final String desc;

  const NFTDetails({Key? key, required this.name, required this.url, required this.desc}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<NFTDetails> createState() => _NFTDetailsState(name: name, url: url, desc: desc);
}

class _NFTDetailsState extends State<NFTDetails> {
  final String name;
  final String url;
  final String desc;

  _NFTDetailsState({required this.name, required this.url, required this.desc});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        title: const Text("NFT", style: ThemeText.whiteTextBold,),
        backgroundColor: ThemeColor.xPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Hero(
                  tag: name,
                  child: Image.network(
                    url,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text(name, style: ThemeText.whiteTextBold,),
              const SizedBox(height: 10,),
              Text(desc, style: ThemeText.whiteTextBold),
            ],
          ),
        )
      )
    );
  }
}