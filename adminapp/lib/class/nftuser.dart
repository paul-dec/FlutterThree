import 'package:adminapp/class/nftart.dart';

class Nftuser {
  final String id;
  final String name;
  final String role;
  final List<Nftart> nfts;

  Nftuser({required this.id, required this.name, required this.role, required this.nfts});

  factory Nftuser.fromJson(Map<dynamic, dynamic> json, String id) {
    var tmp = json['NFT'];
    List<Nftart> tmplist = [];
    tmp.forEach((element) {
      tmplist.add(Nftart.fromJson(element));
    });
    return Nftuser(
        id: id,
        name: json['name'],
        role: json['role'],
        nfts: tmplist
    );
  }
}


