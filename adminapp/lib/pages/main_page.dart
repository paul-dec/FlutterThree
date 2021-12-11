import 'package:adminapp/class/nftuser.dart';
import 'package:adminapp/pages/ntf_page.dart';
import 'package:adminapp/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class MainPage extends StatefulWidget {
  final User user;
  final String role;

  const MainPage({Key? key, required this.user, required this.role}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  late User _currentUser;
  late String _currentRole;
  late Future<List<Nftuser>?> _allNFTs;

  @override
  initState() {
    _currentUser = widget.user;
    _currentRole = widget.role;
    _allNFTs = checkUsers();
    super.initState();
  }

  Future<List<Nftuser>> checkUsers() async {
    List<Nftuser> z = [];

    await FirebaseFirestore.instance.collection("users").get().then(
          (value) {
        for (var element in value.docs) {
          var userDetails = Nftuser.fromJson(element.data(), element.id);
          z.add(userDetails);
        }
      },
    );
    return z;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.xBlue,
        appBar: AppBar(
          title: Text(_currentRole + ' Hello ${_currentUser.email}', style: ThemeText.whiteTextBold,),
          backgroundColor: ThemeColor.xPurple,
          leading: IconButton(onPressed: () => {
            Navigator.of(context)
                .pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            )
          }, icon: const Icon(Icons.logout, color: Colors.white,)),
        ),
        body: FutureBuilder<List<Nftuser>?>(
        future: _allNFTs,
        builder: (BuildContext context, AsyncSnapshot<List<Nftuser>?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              {
                return CircularProgressIndicator();
                // return GridView.count(
                //   crossAxisCount: 2,
                //   children: List.generate(9, (index) {
                //     return (buildNftShimmer());
                //   }),
                // );
              }
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  return (
                    ListView(
                      children: ListTile.divideTiles(
                        color: Colors.deepPurple,
                        tiles: snapshot.data!.map((item) => ListTile(
                          title: Text(item.name, style: ThemeText.whiteTextBold,),
                          subtitle: Text(item.role, style: ThemeText.whiteText,),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white,),
                            onPressed: () {},
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(builder: (context) => NftPage(nfts: item.nfts)),
                            );
                          },
                        ))
                      ).toList()
                    )
                  );
                } else {
                  return Center(
                    child: Text(snapshot.error.toString(), style: ThemeText.xPurpleTextItalic,),
                  );
                }
              }
          }
        }
      )
    );
  }
}