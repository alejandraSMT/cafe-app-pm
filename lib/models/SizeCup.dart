class SizeCup{
  final String size;

  const SizeCup({
    required this.size
  });

   static SizeCup fromJson(json) => SizeCup(size: json['size']);

}