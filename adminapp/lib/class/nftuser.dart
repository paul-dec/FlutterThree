import 'package:adminapp/class/nftart.dart';

class NftUser {
  final String id;
  final String name;
  late final String role;
  final List<NftArt> nfts;

  NftUser({required this.id, required this.name, required this.role, required this.nfts});

  factory NftUser.fromJson(Map<dynamic, dynamic> json, String id) {
    var tmp = json['NFT'];
    List<NftArt> tmpList = [];
    tmp.forEach((element) {
      tmpList.add(NftArt.fromJson(element));
    });
    return NftUser(
        id: id,
        name: json['name'],
        role: json['role'],
        nfts: tmpList
    );
  }
}


