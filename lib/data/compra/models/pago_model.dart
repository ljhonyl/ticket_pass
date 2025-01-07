class PagoModel{
  final num amount;
  final String currency;

  PagoModel({
    required this.amount,
    this.currency='EUR'
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': (amount*100).toInt().toString(),
      'currency': currency,
    };
  }
}