class CardItem{
  int? id;
  String? cardNumber;
  String? holderName;

  CardItem({
    this.id,
    this.cardNumber,
    this.holderName
  });

  CardItem.fromJson(Map<dynamic, dynamic> json){
    id = json['id'];
    cardNumber = json["NumeroTarjeta"];
    holderName = json['NombreTarjeta'];
  }

}