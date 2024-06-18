class User{
  String name;
  String lastname;
  String email;
  String? photo;

  User({
    this.name = "",
    this.lastname = "",
    this.email = "",
    this.photo = ""
  });

  static User fromJson(json) => User(
    name: json['nombre'],
    lastname: json['apellido'],
    email: json['emailAddress'],
    photo: json['foto']
  );
}