class Ingredient {
 final String ingredientName;

  const Ingredient({required this.ingredientName});
  
  static Ingredient fromJson(Map<String,dynamic>json) => Ingredient(ingredientName: json['ingredientName']);
}
