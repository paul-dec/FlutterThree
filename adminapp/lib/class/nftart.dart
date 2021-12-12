class NftArt {
  final String name;
  final String image;
  final String desc;

  NftArt({required this.name, required this.image, required this.desc});

  factory NftArt.fromJson(Map<dynamic, dynamic> json) {
    return NftArt(
        name: json['name'],
        image: json['image'],
        desc: json['desc'],
    );
  }
}


