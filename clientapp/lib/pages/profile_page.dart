import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterthree/class/nft.dart';
import 'package:flutterthree/functions/build_shimmer.dart';
import 'package:flutterthree/functions/nft_api.dart';
import 'package:flutterthree/pages/login_page.dart';
import 'package:flutterthree/pages/upload_page.dart';
import 'package:flutterthree/widgets/nft_card.dart';

import '../styles.dart';
import 'nft_details.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  late User _currentUser;
  late Future<AllNFT?> _allNFTs;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _allNFTs = initNFTs(_currentUser.uid);
  }

  @override
  void dipose(){
    super.dispose();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _allNFTs = refreshNFTs(_currentUser.uid, _allNFTs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
      appBar: AppBar(
        backgroundColor: ThemeColor.xPurple,
        title: Text('Wallet: ${_currentUser.email}', style: ThemeText.whiteTextBold,),
        leading: IconButton(onPressed: () => {
        Navigator.of(context)
            .pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
        )
        }, icon: const Icon(Icons.logout)),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<AllNFT?>(
          future: _allNFTs,
          builder: (BuildContext context, AsyncSnapshot<AllNFT?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(9, (index) {
                      return (buildNftShimmer());
                    }),
                  );
                }
              case ConnectionState.done:
                {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: _refresh,
                        child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(snapshot.data!.all.length, (index) {
                              return Center(
                                  child: NFTCard(
                                    url: snapshot.data!.all[index].image,
                                    name: snapshot.data!.all[index].name,
                                    description: snapshot.data!.all[index].description,
                                    function: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NFTDetails(name: snapshot.data!.all[index].name, url: snapshot.data!.all[index].image, desc: snapshot.data!.all[index].description))),
                                  )
                              );
                            })
                        )
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
        backgroundColor: ThemeColor.xPurple,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPage(uid: _currentUser.uid,))).then((value) => {if (value != Null && value == true) _refresh()}),
      ),
    );
  }
}