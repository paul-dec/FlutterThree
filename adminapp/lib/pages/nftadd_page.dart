import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/web_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NftaddPage extends StatefulWidget {
  final String nftuserid;

  const NftaddPage({Key? key, required this.nftuserid}) : super(key: key);

  @override
  _NftaddPageState createState() => _NftaddPageState();
}
class _NftaddPageState extends State<NftaddPage> {
  late String _nftuserid;
  final TextEditingController _imageTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  @override
  initState() {
    _nftuserid = widget.nftuserid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        title: const Text("Details", style: ThemeText.whiteTextBold,),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        backgroundColor: ThemeColor.xPurple,
      ),
      body:
       Column(
        children: [
          TextField(
            style: ThemeText.whiteText,
            controller: _imageTextController,
            decoration: const InputDecoration(
              hintText: 'Image url',
              hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            style: ThemeText.whiteText,
            controller: _nameTextController,
            decoration: const InputDecoration(
              hintText: 'Name of the NFT',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            style: ThemeText.whiteText,
            controller: _descriptionTextController,
            decoration: const InputDecoration(
              hintText: 'Custom description of the NFT',
              hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    var collection = FirebaseFirestore.instance.collection('users');
                    var docSnapshot = await collection.doc(_nftuserid).get();
                    Map<String, dynamic>? data = docSnapshot.data();
                    data!['NFT'].add({
                      'name': _nameTextController.text,
                      'image': _imageTextController.text,
                      'desc': _descriptionTextController.text
                    });
                    collection.doc(_nftuserid).update(data);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Add an NFT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}