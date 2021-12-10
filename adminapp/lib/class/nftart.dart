class Nftart {
  final String name;
  final String image;
  final String desc;

  Nftart({required this.name, required this.image, required this.desc});

  factory Nftart.fromJson(Map<dynamic, dynamic> json) {
    return Nftart(
        name: json['name'],
        image: json['image'],
        desc: json['desc'],
    );
  }
}


