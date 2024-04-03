class Product{
  final String name;
  final String description;
  final String image;
  final String price;

  const Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price
  });

  static Product fromJson(json) => Product(
    name: json['name'], 
    description: json['description'], 
    image: json['image'], 
    price: json['price']
  );


}