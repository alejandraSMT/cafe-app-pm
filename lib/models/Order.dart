class Order {
  final String number;
  final String date;
  final String payMethod;
  final String price;
  final String quantity;
  final String local;

  Order({
    required this.number,
    required this.date,
    required this.payMethod,
    required this.price,
    required this.quantity,
    required this.local,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      number: json['number'] as String? ?? '',
      date: json['date'] as String? ?? '',
      payMethod: json['payMethod'] as String? ?? '',
      price: json['price'] as String? ?? '',
      quantity: json['quantity'] as String? ?? '',
      local: json['local'] as String? ?? '',
    );
  }
}