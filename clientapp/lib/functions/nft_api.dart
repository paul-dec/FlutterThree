import 'package:flutterthree/class/nft.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future sleepCustom1() {
  return Future.delayed(const Duration(seconds: 1), () => "1");
}

Future sleepCustom2() {
  return Future.delayed(const Duration(seconds: 2), () => "2");
}

Future<AllNFT?> initNFTs(uid) async {
  try {
    final response = await FirebaseFirestore.instance.collection("users").get();

    for (var element in response.docs) {
      if (element.id == uid) {
        if (element.data()['NFT'].length == 0) {
          throw Exception('Add your first NFT');
        }
        AllNFT tmp = AllNFT.fromJson(element.data());
        await sleepCustom2();
        return tmp;
      }
    }
  } catch(e) {
    if (e.toString().contains('Add your first NFT')) {
      throw Exception('Add your first NFT');
    }
    throw Exception('Invalid internet connexion or API is down');
  }
}

Future<AllNFT?> refreshNFTs(uid, _allNFTs) async {
  try {
    final response = await FirebaseFirestore.instance.collection("users").get();

    for (var element in response.docs) {
      if (element.id == uid) {
        AllNFT tmp = AllNFT.fromJson(element.data());
        await sleepCustom2();
        return tmp;
      }
    }
  } catch(e) {
    return _allNFTs;
  }
}
/*
Future<NFTDesc?> getOneNFT(id, url) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/user/getNFT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "url": url
      }),
    );

    if (response.statusCode == 200) {
      NFTDesc tmp = NFTDesc.fromJson(jsonDecode(response.body));
      await sleepCustom1();
      return tmp;
    } else {
      throw Exception('Failed to get NFT.');
    }
  } catch(e) {
    if (e.toString() == 'Exception: Failed to get NFT.') {
      throw Exception('Failed to get NFT.');
    }
    throw Exception('Invalid internet connexion or API is down');
  }
}
*/