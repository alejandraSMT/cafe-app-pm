class MapPoint{
  final String id;
  final String name;
  final String latitude;
  final String longitude;
  final String address;
  final String hours;
  final String image;

  const MapPoint({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.hours,
    required this.image
  });

  static MapPoint fromJson(json) => MapPoint(
    id: json['id'], 
    name: json['name'], 
    latitude: json['latitude'], 
    longitude: json['longitude'], 
    address: json['address'],
    hours: json['hours'],
    image: json['image']
  );


}