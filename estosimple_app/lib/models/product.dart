class Product {
  final int id;
  final String name;
  final String sku;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.description,
    required this.price
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'], 
      name: json['name'], 
      sku: json['sku'], 
      description: json['description'], 
      price: json['price']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'description': description,
      'price': price
    };
  }
}