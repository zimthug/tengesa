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
    notifyListeners();
  }

  void removeSale(int saleId) {
    notifyListeners();
  }

  void updateSaleCurrency(Sales sales) {
    notifyListeners();
  }

  void addProduct(SaleItems salesItem) {
    int i = 0;
    saleItemsList.forEach((f) {
      if (f.productId == salesItem.productId) {
        salesItem.quantity++;
        saleItemsList.removeAt(i);
        saleItemsList.add(salesItem);
        notifyListeners();
        return;
      }
      i++;
    });
    salesItem.saleItemId = i;
    saleItemsList.add(salesItem);
    notifyListeners();
    return;
  }

/*
  void addProduct(SaleProduct saleProduct){
    int productId = saleProduct.saleItems.productId;
    saleProductsList.forEach((f)  {
      if(f.saleItems.productId == productId){
        saleProduct.units++;
        notifyListeners();
        return;
      }
    });

    saleProduct.saleProductId = saleProductsList.length;

    saleProductsList.add(saleProduct);
    notifyListeners();
  }
*/

}
