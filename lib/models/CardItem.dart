class CardItem{
  int id = -1;
  String cardNumber = "";
  String holderName = "";

  CardItem({
    required this.id,
    required this.cardNumber,
    required this.holderName
  });

  CardItem.fromJson(Map<dynamic, dynamic> json){
    id = json['id'];
    cardNumber = json["numeroTarjeta"];
    holderName = json['nombreTarjeta'];
  }

}