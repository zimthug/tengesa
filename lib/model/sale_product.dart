import 'package:tengesa/model/sales.dart';

class SaleProduct {
  int saleProductId;
  SaleItems saleItems;
  List<ItemPrices> itemPrices;
  double units;
  int currencyId;

  SaleProduct(this.saleProductId, this.saleItems, this.itemPrices, this.units, this.currencyId);

  SaleProduct.fromMap(dynamic obj) {
    this.saleProductId = obj["sale_product_id"];
    this.saleItems = obj["saleItem"];
    this.itemPrices = obj["itemPrices"];
    this.units = obj["units"];
    this.currencyId = obj["currency_id"];
  }

}

class ItemPrices {
  int productId;
  int currencyId;
  double price;

  ItemPrices(this.productId, this.currencyId, this.price);

  ItemPrices.fromMap(dynamic obj) {
    this.productId = obj["product_id"];
    this.currencyId = obj["currency_id"];
    this.price = obj["price"];
  }
}
