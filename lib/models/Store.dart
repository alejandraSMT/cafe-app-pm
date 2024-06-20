class Store{

  String name;
  String latitude;
  String longitude;
  String hours;
  String address;
  String image;

  Store({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.hours,
    required this.address,
    required this.image
  });

  static Store fromJson(json) => Store(
    name: json['Nombre'],
    latitude: json['Latitud'],
    longitude: json['Longitud'],
    hours: json['Horario'],
    address: json['Direccion'],
    image: json['Imagen']
  );

}