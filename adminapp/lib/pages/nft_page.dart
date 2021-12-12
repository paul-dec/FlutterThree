import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/web_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nftdetails_page.dart';

class NftPage extends StatefulWidget {
  final List<Nftart> nfts;
  final String nftuserid;

  const NftPage({Key? key, required this.nfts, required this.nftuserid}) : super(key: key);

  @override
  _NftPageState createState() => _NftPageState();
}
class _NftPageState extends State<NftPage> {
  late List<Nftart> _currentNft;
  late String _nftuserid;

  @override
  initState() {
    _currentNft = widget.nfts;
    _nftuserid = widget.nftuserid;
    super.initState();
  }

  _refresh() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        title: const Text("Details", style: ThemeText.whiteTextBold,),
        backgroundColor: ThemeColor.xPurple,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(_currentNft.length, (index) {
          return GestureDetector(
            child:
              Column(
                children: [
                  WebImage(url: _currentNft[index].image),
                  Text(_currentNft[index].name, style: ThemeText.whiteTextBold,),
                  Text(_currentNft[index].desc, style: ThemeText.whiteText,)
                ],
              ),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NftdetailsPage(nft: _currentNft[index], nftuserid: _nftuserid, nftnumber: index))).then((value) => {if (value != Null && value == true) _refresh()}),
            },
          );
        }),
    ));
  }
}