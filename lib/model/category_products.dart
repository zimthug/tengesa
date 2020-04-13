class CategoryProducts {
  int categoryId;
  String category;
  int products;

  CategoryProducts(this.categoryId, this.category, this.products);

  CategoryProducts.fromMap(dynamic obj) {
    this.categoryId = obj["category_id"];
    this.category = obj["category"];
    this.products = obj["products"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category_id": categoryId,
      "category": category,
      "products": products,
    };
  }
}
