class User{
  final String name;
  final String lastname;
  final String email;
  final String password;

  const User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password
  });

  static User fromJson(json) => User(
    name: json['nombre'],
    lastname: json['apellido'],
    email: json['emailAdress'],
    password: json['contraseña']
  );
}