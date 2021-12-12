import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/web_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NftdetailsPage extends StatefulWidget {
  final Nftart nft;
  final String nftuserid;

  const NftdetailsPage({Key? key, required this.nft, required this.nftuserid}) : super(key: key);

  @override
  _NftdetailsPageState createState() => _NftdetailsPageState();
}
class _NftdetailsPageState extends State<NftdetailsPage> {
  late Nftart _currentNft;
  late String _nftuserid;
  final TextEditingController _imageTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  @override
  initState() {
    _currentNft = widget.nft;
    _nftuserid = widget.nftuserid;
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
          TextFormField(
            style: ThemeText.whiteText,
            controller: _imageTextController,
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            style: ThemeText.whiteText,
            controller: _nameTextController,
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            style: ThemeText.whiteText,
            controller: _descriptionTextController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
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