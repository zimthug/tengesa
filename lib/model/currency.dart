class Currency {
  int currencyId;
  String currency;
  String currencyCode;
  String currencySign;

  Currency(this.currencyId, this.currency, this.currencyCode, this.currencySign);

  Currency.fromMap(dynamic obj) {
    this.currencyId = obj["currency_id"];
    this.currency = obj["currency"];
    this.currencyCode = obj["currency_code"];
    this.currencySign = obj["currency_sign"];
  }

  Map<String, dynamic> toMap() {
    return {
      "currency_id": currencyId,
      "currency": currency,
      "currency_code": currencyCode,
      "currency_sign": currencySign,
    };
  }
  
}
