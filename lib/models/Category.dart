class Category{
  final int id;
  final String name;

  const Category({
    required this.id,
    required this.name
  });

  static Category fromJson(json) => Category(
    id: json['id'], 
    name: json['name']
  );
}