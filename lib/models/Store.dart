class Store{
  int id = -1;
  String name = "";
  double latitude = 0.0;
  double longitude = 0.0;
  String hours = "";
  String address = "";
  String image = "";

  Store({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.hours,
    required this.address,
    required this.image
  });

  Store.fromJson(Map<dynamic,dynamic> json){
    id = json['id'];
    name = json['Nombre'];
    latitude = json['Latitud'];
    longitude = json['Longitud'];
    hours = json['Horario'];
    address = json['Direccion'];
    image = json['Imagen'];
  }
}