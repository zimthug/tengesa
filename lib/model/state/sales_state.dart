import 'package:scoped_model/scoped_model.dart';
import 'package:tengesa/model/currency.dart';
import 'package:tengesa/model/sale_product.dart';
import 'package:tengesa/model/sales.dart';
import 'package:tengesa/utils/database/db_manager.dart';
import 'package:tengesa/utils/funcs.dart';

class SalesStateModel extends Model {
  DbManager db = DbManager();
  Sales sale;
  List<Sales> sales = [];
  List<SaleItems> saleItemsList = [];
  List<SaleProduct> saleProductsList = [];

  void addSale() async {
    int saleId = await db.getMaxSaleId();
    String startDt = Funcs.currentDateAsStr();
    sale = Sales(saleId, 100, startDt, "", 501, 0, 0);
    calculateTotal();
    notifyListeners();
  }

  void addProduct(SaleItems saleItem) {
    for (var item in saleItemsList) {
      if (item.productId == saleItem.productId) {
        //print("Current quantity is ${saleItem.quantity.toString()}");
        //updateProduct(saleItem, saleItem.quantity+1, i);
        item.quantity++;
        calculateTotal();
        notifyListeners();
        return null;
      }
    }
    saleItemsList.add(saleItem);
    calculateTotal();
    notifyListeners();
  }

  /*
  void updateProduct(SaleItems saleItem, double quantity, int index) {
    //print("New quantity is ${quantity.toString()} at index ${index.toString()}");

    int index =
        saleItemsList.indexWhere((i) => i.productId == saleItem.productId);
    saleItemsList[index].quantity = quantity;
    if (saleItemsList[index].quantity == 0) removeProduct(saleItem);

    calculateTotal();
    notifyListeners();
  }
  */

  void removeProduct(SaleItems saleItem) {
    int index =
        saleItemsList.indexWhere((i) => i.productId == saleItem.productId);
    saleItemsList[index].quantity = 1;
    saleItemsList.removeWhere((item) => item.productId == saleItem.productId);
    calculateTotal();
    notifyListeners();
  }

  void calculateTotal() {
    double totPrice = 0;
    saleItemsList.forEach((f) {
      totPrice += f.unitPrice * f.quantity;
    });
    sale.totalPrice = totPrice;
    //Sales(saleId, saleStatus, startDate, endDate, currencyId, totalPrice, totalVat);
  }

  Future<void> changeCurrency(int currency) async {
    double price = 0;
    double totPrice = 0;

    /*
    saleItemsList.forEach((item) {
      db.getProductPrice(item.productId, currency).then((prv){
        price += prv * item.quantity;
        //print("Item price is ${price.toString()} and quantity is ${item.quantity.toString()}");
      }).whenComplete(() {
        //print("Price is ${price.toStringAsFixed(2)}");
        sale.totalPrice = price;
      });
    });
    */

    for (var item in saleItemsList) {
      price = await db.getProductPrice(item.productId, currency);
      totPrice += price * item.quantity;
	  item.currencyId = currency;
	  item.unitPrice = price;
	  item.totalPrice = price * item.quantity;
      print(
          "Item price is ${price.toString()} and total is ${totPrice.toString()}");
    }

    sale.currencyId = currency;
    sale.totalPrice = totPrice;
    print("Price changed to ${sale.totalPrice.toString()}");
  }

  Future<List<Currency>> getCurrencyData() {
    return db.getCurrencyData();
  }
}
