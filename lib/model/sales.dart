class Sales {
  int saleId;
  int saleStatus;
  String startDate;
  String endDate;
  int currencyId;
  double totalPrice;
  double totalVat;

  Sales(this.saleId, this.saleStatus, this.startDate, this.endDate,
      this.currencyId, this.totalPrice, this.totalVat);

  Sales.fromMap(dynamic obj) {
    this.saleId = obj["sale_id"];
    this.saleStatus = obj["sale_status"];
    this.startDate = obj["start_date"];
    this.endDate = obj["end_date"];
    this.currencyId = obj["currency_id"];
    this.totalPrice = obj["total_price"];
    this.totalVat = obj["total_vat"];
  }
}

class SaleItems {
  int saleItemId;
  int saleId;
  int productId;
  double quantity;
  double unitPrice;
  int currencyId;
  double totalPrice;
  String product;

  SaleItems(this.saleItemId, this.saleId, this.productId, this.quantity,
      this.unitPrice, this.currencyId, this.totalPrice, this.product);

  SaleItems.fromMap(dynamic obj) {
    this.saleItemId = obj["sale_item_id"];
    this.saleId = obj["sale_id"];
    this.productId = obj["product_id"];
    this.quantity = obj["quantity"];
    this.unitPrice = obj["unit_price"];
    this.currencyId = obj["currency_id"];
    this.totalPrice = obj["total_price"];
    this.product = obj["product"];
  }
}
