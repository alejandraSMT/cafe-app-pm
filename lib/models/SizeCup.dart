class SizeCup{
  final int id;
  final String size;

  const SizeCup({
    required this.id,
    required this.size
  });

  static SizeCup fromJson(json) => SizeCup(
    id: json['id'],
    size: json['size']
  );

}