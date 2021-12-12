import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/web_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NftdetailsPage extends StatefulWidget {
  final Nftart nft;
  final String nftuserid;
  final int nftnumber;

  const NftdetailsPage({Key? key, required this.nft, required this.nftuserid, required this.nftnumber}) : super(key: key);

  @override
  _NftdetailsPageState createState() => _NftdetailsPageState();
}
class _NftdetailsPageState extends State<NftdetailsPage> {
  late Nftart _currentNft;
  late String _nftuserid;
  late int _nftnumber;
  // final TextEditingController _imageTextController = TextEditingController();
  // final TextEditingController _nameTextController = TextEditingController();
  // final TextEditingController _descriptionTextController = TextEditingController();
  late TextEditingController _imageTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _descriptionTextController;

  @override
  initState() {
    _currentNft = widget.nft;
    _nftuserid = widget.nftuserid;
    _nftnumber = widget.nftnumber;
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
        backgroundColor: ThemeColor.xPurple,
      ),
      body:
       Column(
        children: [
          WebImage(url: _currentNft.image),
          Text(_currentNft.name, style: ThemeText.whiteTextBold,),
          Text(_currentNft.desc, style: ThemeText.whiteText,),
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
                    var docSnapshot = await collection.doc(_nftuserid).get();
                    Map<String, dynamic>? data = docSnapshot.data();
                    data!['NFT'][_nftnumber]['desc'] = _descriptionTextController.text;
                    data!['NFT'][_nftnumber]['image'] = _imageTextController.text;
                    data!['NFT'][_nftnumber]['name'] = _nameTextController.text;
                    collection.doc(_nftuserid).update(data);
                  },
                  child: const Text(
                    'Edit NFT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    var collection = FirebaseFirestore.instance.collection('users');
                    var docSnapshot = await collection.doc(_nftuserid).get();
                    Map<String, dynamic>? data = docSnapshot.data();
                    data!['NFT'].removeAt(_nftnumber);
                    collection.doc(_nftuserid).update(data);
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
    );
  }
}