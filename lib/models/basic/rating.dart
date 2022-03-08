class Rating {
  static const AMOUNT = "amount";
  static const VOTES = "votes";

  Rating({this.amount, this.votes});

  num? amount;
  String? votes;

  static fromMap(Map<String, dynamic>? data) {
    return Rating(amount: data?[AMOUNT], votes: data?[VOTES]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AMOUNT: this.amount,
      VOTES: this.votes,
    };
  }

  String? get ratingString => (amount == null) ? null : amount!.toStringAsFixed(2);
}
