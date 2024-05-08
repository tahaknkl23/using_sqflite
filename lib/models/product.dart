class Product {
  int? id;
  String name;
  String description;
  double unPrice;

  Product({
    required this.name,
    required this.description,
    required this.unPrice,
    this.id,
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
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Product.fromObject(dynamic o)
      : name = '',
        description = '',
        unPrice = 0.0 {
    id = int.tryParse(o["id"].toString());
    name = o["name"];
    description = o["description"];
    unPrice = double.tryParse(o["unitPrice"].toString())!;
  }

  // void a() {
  //   var urun = Product(name: "Laptop", description: "Açİklama", unPrice: 2500);
  //   var mapUrun = urun.toMap();
  // }
}
