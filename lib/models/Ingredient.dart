class Ingredient {
  int id;
  String ingredientName;

  Ingredient({
    required this.id,
    required this.ingredientName
  });
  
  static Ingredient fromJson(json) => Ingredient(
    id: json['id'],
    ingredientName: json['Nombre']
  );
}
