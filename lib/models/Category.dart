class Category{
  int? id;
  String? name;
  String? description;

  Category({
    this.id,
    this.name,
    this.description
  });

  static Category fromJson(json) => Category(
    id: json['id'], 
    name: json['Nombre'],
    description: json['Descripcion']
  );
}