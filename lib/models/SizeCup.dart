class SizeCup{
  final String size;

  const SizeCup({
    required this.size
  });

   static SizeCup fromJson(Map<String,dynamic>json) => SizeCup(size: json['size']);

}