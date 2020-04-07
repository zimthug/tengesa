class Category {
  int categoryId;
  int branchId;
  String category;

  Category(this.categoryId, this.branchId, this.category);

  /*
  factory Category.fromJson(Map<String, dynamic> data) => new Category(
      categoryId: data["categoryId"],
      branchId: data["branchId"],
      category: data["category"]);
      */

  Category.fromMap(dynamic obj) {
    this.categoryId = obj["category_id"];
    this.branchId = obj["branch_id"];
    this.category = obj["category"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category_id": categoryId,
      "branch_id": branchId,
      "category": category,
    };
  }

  int get getCategoryId => categoryId;
  int get getBranchId => branchId;
  String get getCategory => category;
}
