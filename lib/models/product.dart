class Product {
  final int? id;
  final String name;
  final String description;
  final double unPrice;

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
}
