class CardItem{
  int id;
  String cardNumber;
  String holderName;

  CardItem({
    required this.id,
    required this.cardNumber,
    required this.holderName
  });

  static CardItem fromJson(json) => CardItem(
    id: json['id'],
    cardNumber: json['numeroTarjeta'],
    holderName: json['nombreTarjeta']
  );

}