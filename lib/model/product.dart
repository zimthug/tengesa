class Product {
  int productId;
  int categoryId;
  String product;
  String productCode;
  int productMeasureId;

  Product(this.productId, this.categoryId, this.product, this.productCode,
      this.productMeasureId);

  Product.fromMap(dynamic obj) {
    this.productId = obj["product_id"];
    this.categoryId = obj["category_id"];
    this.product = obj["product"];
    this.productCode = obj["product_code"];
    this.productMeasureId = obj["product_measure_id"];
  }

  Map<String, dynamic> toMap() {
    return {
      "product_id": productId,
      "category_id": categoryId,
      "product": product,
      "product_code": productCode,
      "product_measure_id": productMeasureId,
    };
  }
}

class ProductPrice {
  int productPriceId;
  int productId;
  int currencyId;
  double price;

  ProductPrice(
      this.productPriceId, this.productId, this.currencyId, this.price);

  ProductPrice.fromMap(dynamic obj) {
    this.productPriceId = obj["product_price_id"];
    this.productId = obj["product_id"];
    this.currencyId = obj["currency_id"];
    this.price = obj["price"];
  }

  Map<String, dynamic> toMap() {
    return {
      "product_price_id": productPriceId,
      "product_id": productId,
      "currency_id": currencyId,
      "price": price,
    };
  }
}

class ProductStock {
  int productStockId;
  int productId;
  double minStock;
  double maxStock;
  double currentStock;

  ProductStock(this.productStockId, this.productId, this.minStock,
      this.maxStock, this.currentStock);

  ProductStock.fromMap(dynamic obj) {
    this.productStockId = obj["product_stock_id"];
    this.productId = obj["product_id"];
    this.minStock = obj["min_stock"];
    this.maxStock = obj["max_stock"];
    this.currentStock = obj["current_stock"];
  }

  Map<String, dynamic> toMap() {
    return {
      "product_stock_id": productStockId,
      "product_id": productId,
      "min_stock": minStock,
      "max_stock": maxStock,
      "current_stock": currentStock
    };
  }
}

class ProductDetails {
  int productId;
  int categoryId;
  String product;
  String productCode;
  int productMeasureId;
  String category;
  double minStock;
  double maxStock;
  double currentStock;
  double rtgs;
  double ecocash;
  double usd;

  ProductDetails(
      this.productId,
      this.categoryId,
      this.product,
      this.productCode,
      this.productMeasureId,
      this.category,
      this.minStock,
      this.maxStock,
      this.currentStock,
      this.rtgs,
      this.ecocash,
      this.usd);

  ProductDetails.fromMap(dynamic obj) {
    this.productId = obj["product_id"];
    this.categoryId = obj["category_id"];
    this.product = obj["product"];
    this.productCode = obj["product_code"];
    this.productMeasureId = obj["product_measure_id"];
    this.category = obj["category"];
    this.minStock = obj["min_stock"];
    this.maxStock = obj["max_stock"];
    this.currentStock = obj["current_stock"];
    this.rtgs = obj["rtgs"];
    this.ecocash = obj["ecocash"];
    this.usd = obj["usd"];
  }

  Map<String, dynamic> toMap() {
    return {
      "product_id": productId,
      "category_id": categoryId,
      "product": product,
      "product_code": productCode,
      "product_measure_id": productMeasureId,
      "category": category,
      "min_stock": minStock,
      "max_stock": maxStock,
      "current_stock": currentStock,
      "rtgs": rtgs,
      "ecocash": ecocash,
      "usd": usd,
    };
  }
}
