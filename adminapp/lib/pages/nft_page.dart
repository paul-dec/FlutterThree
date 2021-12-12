import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/functions/nft_api.dart';
import 'package:adminapp/styles.dart';
import 'package:adminapp/widgets/web_image.dart';
import 'package:flutter/material.dart';

import 'nftadd_page.dart';
import 'nftdetails_page.dart';

class NftPage extends StatefulWidget {
  final List<NftArt> nfts;
  final String nftUserID;

  const NftPage({Key? key, required this.nfts, required this.nftUserID}) : super(key: key);

  @override
  _NftPageState createState() => _NftPageState();
}
class _NftPageState extends State<NftPage> {
  late Future<List<NftArt>?> _currentNft;
  late String _nftUserID;

  @override
  initState() {
    _currentNft = _init();
    _nftUserID = widget.nftUserID;
    super.initState();
  }

  Future<List<NftArt>> _init() async {
      return widget.nfts;
  }

  Future<void> _refresh() async {
    setState(() {
      _currentNft = refreshNFTs(_nftUserID, _currentNft).then((value) => value?.nfts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        title: const Text("Details", style: ThemeText.whiteTextBold,),
        backgroundColor: ThemeColor.xPurple,
      ),
      body: FutureBuilder<List<NftArt>?>(
          future: _currentNft,
          builder: (BuildContext context, AsyncSnapshot<List<NftArt>?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              case ConnectionState.done:
                {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(snapshot.data!.length, (index) {
                        return GestureDetector(
                          child:
                          Column(
                            children: [
                              WebImage(url: snapshot.data![index].image),
                              Text(snapshot.data![index].name, style: ThemeText.whiteTextBold,),
                            ],
                          ),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NftDetailsPage(nft: snapshot.data![index], nftUserID: _nftUserID, nftNumber: index))).then((value) => {if (value != Null && value == true) _refresh()}),
                          },
                        );
                      }),
                    );
                  } else {
                    return Center(
                      child: Text(snapshot.error.toString(), style: ThemeText.whiteTextBold),
                    );
                  }
                }
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NftaddPage(nftuserid: _nftUserID))).then((value) => {if (value != Null && value == true) _refresh()});
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}