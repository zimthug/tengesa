//import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:tengesa/model/currency.dart';
import 'package:tengesa/model/product.dart';
import 'package:tengesa/model/sale_product.dart';
import 'package:tengesa/model/sales.dart';
import 'package:tengesa/utils/database/db_manager.dart';
import 'package:tengesa/utils/funcs.dart';

class SalesStateModel with ChangeNotifier {
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
        item.quantity++;
        item.totalPrice = item.unitPrice * item.quantity;
        calculateTotal();
        notifyListeners();
        return null;
      }
    }
    saleItemsList.add(saleItem);
    calculateTotal();
    notifyListeners();
  }

  void removeProduct(SaleItems saleItem) {
    for (var item in saleItemsList) {
      if (item.productId == saleItem.productId) {
        item.quantity--;
        if (item.quantity > 0) {
          item.totalPrice = item.unitPrice * item.quantity;
          calculateTotal();
          notifyListeners();
          return null;
        }
        saleItemsList
            .removeWhere((item) => item.productId == saleItem.productId);
        calculateTotal();
        notifyListeners();
        return null;
      }
    }
    calculateTotal();
    notifyListeners();
  }

  void calculateTotal() {
    double totPrice = 0;
    saleItemsList.forEach((f) {
      totPrice += f.unitPrice * f.quantity;
    });
    sale.totalPrice = totPrice;
  }

  Future<void> changeCurrency(int currency) async {
    double price = 0;
    double totPrice = 0;

    for (var item in saleItemsList) {
      price = await db.getProductPrice(item.productId, currency);
      totPrice += price * item.quantity;
      item.currencyId = currency;
      item.unitPrice = price;
      item.totalPrice = price * item.quantity;
    }

    sale.currencyId = currency;
    sale.totalPrice = totPrice;
    notifyListeners();
  }

  Future<List<Currency>> getCurrencyData() {
    return db.getCurrencyData();
  }

  Future<List<ProductDetails>> getProductDetailsData() {
    return db.getProductsDetails(0, 0);
  }
}
