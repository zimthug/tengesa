import 'package:tengesa/model/currency.dart';
import 'package:tengesa/model/product_measure.dart';
import 'package:tengesa/model/user.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class InitializeDb {
  DbManager db = DbManager();

  Future<void> intializeDatabase() {
    print("Adding currencies");

    List<Currency> currencyList = [
      Currency(501, "Zim RTGS", "RTGS\$", "RTGS\S"),
      Currency(502, "Ecocash", "RTGS\$", "RTGS\S"),
      Currency(503, "USD", "USD", "\S")
    ];

    currencyList.forEach((cur) {
      db.saveCurrencyData(cur);
    });

    print("Adding product_measures");

    List<ProductMeasure> productMeasureList = [
      ProductMeasure(201, "L", "Litre"),
      ProductMeasure(202, "ML", "Millilitre"),
      ProductMeasure(203, "KG", "Kilogram"),
      ProductMeasure(204, "G", "Milligram"),
      ProductMeasure(205, "M", "Metre"),
      ProductMeasure(206, "CM", "Centimeter"),
      ProductMeasure(207, "U", "Unit")
    ];

    productMeasureList.forEach((prod) {
      db.saveProductMeasureData(prod);
    });

    return null;
  }

  Future<void> intializeTestUser() {
    /* This function is only used for testing */
    print("Adding users");
    User u01 = User(10, "cashier@tengesa.co.zw", "cashier", "123654", "CASHIER",
        10001, " ");
    User u02 =
        User(50, "admin@tengesa.co.zw", "admin", "123654", "ADMIN", 10001, " ");
    db.saveUserData(u01);
    db.saveUserData(u02);

    return null;
  }
}
