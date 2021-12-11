import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/web_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NftPage extends StatefulWidget {
  final List<Nftart> nfts;

  const NftPage({Key? key, required this.nfts}) : super(key: key);

  @override
  _NftPageState createState() => _NftPageState();
}
class _NftPageState extends State<NftPage> {
  late List<Nftart> _currentNft;

  @override
  initState() {
    _currentNft = widget.nfts;
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
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(_currentNft.length, (index) {
          return Column(
              children: [
                WebImage(url: _currentNft[index].image),
                Text(_currentNft[index].name, style: ThemeText.whiteTextBold,),
                Text(_currentNft[index].desc, style: ThemeText.whiteText,)
              ],
          );
        }),
    ));
  }
}