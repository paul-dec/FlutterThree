class AllNFT {
  final List<NFT> all;

  AllNFT({required this.all});

  factory AllNFT.fromJson(Map<dynamic, dynamic> json) {
    var data = <NFT>[];
    json['NFT'].forEach((v) {
      data.add(NFT.fromJson(v));
    });
    return AllNFT(
      all: data,
    );
  }
}

class NFT {
  final String name;
  final String image;
  final String description;

  NFT({required this.name, required this.image, required this.description});

  factory NFT.fromJson(Map<dynamic, dynamic> json) {
    return NFT(
        name: json['name'],
        image: json['image'],
        description: json['desc']
    );
  }
}

class NFTDesc {
  final String name;
  final String description;

  NFTDesc({required this.name, required this.description});

  factory NFTDesc.fromJson(Map<dynamic, dynamic> json) {
    return NFTDesc(
        name: json['name'],
        description: json['desc']
    );
  }
}