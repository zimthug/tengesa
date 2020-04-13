class ProductMeasure {
  int productMeasureId;
  String productAbbrv;
  String productMeasure;

  ProductMeasure(this.productMeasureId, this.productAbbrv, this.productMeasure);

  ProductMeasure.fromMap(dynamic obj) {
    this.productMeasureId = obj["product_measure_id"];
    this.productAbbrv = obj["product_abbrv"];
    this.productMeasure = obj["product_measure"];
  }

  Map<String, dynamic> toMap() {
    return {
      "product_measure_id": productMeasureId,
      "product_abbrv": productAbbrv,
      "product_measure": productMeasure,
    };
  }
}
