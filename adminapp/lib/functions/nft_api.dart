import 'package:adminapp/class/nftart.dart';
import 'package:adminapp/class/nftuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future sleepCustom1() {
  return Future.delayed(const Duration(seconds: 1), () => "1");
}

Future sleepCustom2() {
  return Future.delayed(const Duration(seconds: 2), () => "2");
}

Future<NftUser?> refreshNFTs(uid, _allNFTs) async {
  try {
    final response = await FirebaseFirestore.instance.collection("users").get();

    for (var element in response.docs) {
      if (element.id == uid) {
        var userDetails = NftUser.fromJson(element.data(), element.id);
        await sleepCustom2();
        return userDetails;
      }
    }
  } catch(e) {
    return _allNFTs;
  }
}