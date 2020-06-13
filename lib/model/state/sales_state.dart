import 'package:scoped_model/scoped_model.dart';
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
    int index =
        saleItemsList.indexWhere((i) => i.productId == saleItem.productId);
    print(index);
    if (index != -1) {
      updateProduct(saleItem, saleItem.quantity + 1);
    } else {
      saleItemsList.add(saleItem);
      calculateTotal();
      notifyListeners();
    }
  }

  void updateProduct(SaleItems saleItem, double quantity) {
    int index =
        saleItemsList.indexWhere((i) => i.productId == saleItem.productId);
    saleItemsList[index].quantity = quantity;
    if (saleItemsList[index].quantity == 0) removeProduct(saleItem);

    calculateTotal();
    notifyListeners();
  }

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

  void changeCurrency(int currency) {
    double price = 0;
    double totPrice = 0;
    
    saleItemsList.forEach((item) {
      db.getProductPrice(item.productId, currency).then((prv){
        price += prv * item.quantity;
        //print("Item price is ${price.toString()} and quantity is ${item.quantity.toString()}");
      }).whenComplete(() {
        //print("Price is ${price.toStringAsFixed(2)}");
        sale.totalPrice = price;
      });
    });
  }   

}
