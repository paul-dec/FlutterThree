import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterthree/widgets/nft_card.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  List<String> nfts = [
    'https://lh3.googleusercontent.com/GVEpa2Ijl4P7X9by-ewolxAGowGLz4tAOeKpiEIknMceLO6DmVbHqkmOlCE3N_Tkan8m0tyDET_-WTSv9cJShdF2y3XNFYc6SPdb=w335',
    'https://lh3.googleusercontent.com/XvgxjCF2ZgGVnH0sV4Gsi2culHTnyWHHzypembKMKXNm0TfMhMA5-lRs529Tn_wJEewidNYWMeHW7gzcE2o31YvLW8HJZDonu9FJ=w335',
    'https://lh3.googleusercontent.com/Va2Globuksc2UkgiLnjdNZlZVSOCx52kAhSTzYISlmkhGN0cUnLjQBi2d4DGomFShglNekv5ZHOFlZ26jUc_MgTPCyeRHM-TxOgk=w335',
    'https://lh3.googleusercontent.com/pQCVnXbnvzZTBFywvhpdm4sf6KsAG_EYVu_mAW4kjVWdNGa6f9vtmks5mnvcxNWnLdRb1yWd4NkpnICNHMuhpYxXhbDUO3cqrE2LuGY=w335',
    'https://lh3.googleusercontent.com/ZFIxzeqJ3HENutDe8FZtgIhuxLAgfq6oWIBYV4p3Sf_TjKOTNJ9Pp524G2GHHAkAc6lth-ql0-df87oCbsVyIeZLX2UozBPYGVY20g=w335'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet: ${_currentUser.email}'),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(nfts.length, (index) {
            return Center(
                child: NFTCard(
                    url: nfts[index],
                    name: nfts[index],
                    description: nfts[index]
                ));
          })
      )
    );
  }
}