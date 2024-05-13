class Product {
  late int id;
  String name;
  String description;
  double unPrice;

  Product({
    required this.name,
    required this.description,
    required this.unPrice,
    required this.id,
  });
  Product.withId({
    required this.id,
    required this.name,
    required this.description,
    required this.unPrice,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unPrice;
    map["id"] = id;
    return map;
  }

  Product.fromObject(dynamic o)
      : name = '',
        description = '',
        unPrice = 0.0 {
    id = o["id"];
    name = o["name"];
    description = o["description"];
    unPrice = double.tryParse(o["unitPrice"].toString())!;
  }

  // void a() {
  //   var urun = Product(name: "Laptop", description: "Açİklama", unPrice: 2500);
  //   var mapUrun = urun.toMap();
  // }
}
