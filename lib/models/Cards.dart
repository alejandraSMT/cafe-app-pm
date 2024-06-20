import 'package:cafe_app/models/CardItem.dart';

class Cards {
  List<CardItem>? cards;

  Cards({this.cards});

  Cards.fromJson(Map<String, dynamic> json) {
    if (json['tarjetas'] != null) {
      cards = <CardItem>[];
      (json['tarjetas'] as List).forEach((element) {
        cards!.add(CardItem.fromJson(element));
      });
    }
  }
}
