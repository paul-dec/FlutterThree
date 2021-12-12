import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/web_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NftDetailsPage extends StatefulWidget {
  final NftArt nft;
  final String nftUserID;
  final int nftNumber;

  const NftDetailsPage({Key? key, required this.nft, required this.nftUserID, required this.nftNumber}) : super(key: key);

  @override
  _NftDetailsPageState createState() => _NftDetailsPageState();
}
class _NftDetailsPageState extends State<NftDetailsPage> {
  late NftArt _currentNft;
  late String _nftUserid;
  late String _nftName;
  late String _nftImage;
  late String _nftDesc;
  late int _nftNumber;
  late TextEditingController _imageTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _descriptionTextController;
  bool isChange = false;

  @override
  initState() {
    _currentNft = widget.nft;
    _nftName = _currentNft.name;
    _nftImage = _currentNft.image;
    _nftDesc = _currentNft.desc;
    _nftUserid = widget.nftUserID;
    _nftNumber = widget.nftNumber;
    _imageTextController = TextEditingController(text: _currentNft.image);
    _nameTextController = TextEditingController(text: _currentNft.name);
    _descriptionTextController = TextEditingController(text: _currentNft.desc);
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
            Navigator.of(context).pop(isChange);
          },
        ),
        backgroundColor: ThemeColor.xPurple,
      ),
<<<<<<< HEAD
      body:
       Column(
        children: [
          WebImage(url: _nftimage),
          Text(_nftname, style: ThemeText.whiteTextBold,),
          Text(_nftdesc, style: ThemeText.whiteText,),
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
                hintStyle: TextStyle(color: Colors.grey)
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
=======
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
>>>>>>> 8559d3857f3b4468742743e838c3c625a7101bd8
            children: [
              WebImage(url: _nftImage),
              Text(_nftName, style: ThemeText.whiteTextBold,),
              Text(_nftDesc, style: ThemeText.whiteText,),
              TextField(
                style: ThemeText.whiteText,
                controller: _imageTextController,
              ),
              const SizedBox(height: 8.0),
              TextField(
                style: ThemeText.whiteText,
                controller: _nameTextController,
              ),
              const SizedBox(height: 8.0),
              TextField(
                style: ThemeText.whiteText,
                controller: _descriptionTextController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var collection = FirebaseFirestore.instance.collection('users');
                        var docSnapshot = await collection.doc(_nftUserid).get();
                        Map<String, dynamic>? data = docSnapshot.data();
                        data!['NFT'][_nftNumber]['desc'] = _descriptionTextController.text;
                        data['NFT'][_nftNumber]['image'] = _imageTextController.text;
                        data['NFT'][_nftNumber]['name'] = _nameTextController.text;
                        collection.doc(_nftUserid).update(data);
                        isChange = true;
                        setState(() {
                          _nftDesc = _descriptionTextController.text;
                          _nftImage = _imageTextController.text;
                          _nftName = _nameTextController.text;
                        });
                      },
                      child: const Text(
                        'Edit NFT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var collection = FirebaseFirestore.instance.collection('users');
                        var docSnapshot = await collection.doc(_nftUserid).get();
                        Map<String, dynamic>? data = docSnapshot.data();
                        data!['NFT'].removeAt(_nftNumber);
                        collection.doc(_nftUserid).update(data);
                        isChange = true;
                      },
                      child: const Text(
                        'Delete NFT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      )
    );
  }
}