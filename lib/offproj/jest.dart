void main(List<String> args) {

  print("=== Test ===");

  List<ChickModel> chickModelList = [];

  ChickModel chick01 = ChickModel(100, "AAA");
  ChickModel chick02 = ChickModel(101, "BBB");
  ChickModel chick03 = ChickModel(102, "CCC");

  chickModelList.add(chick01);
  chickModelList.add(chick02);
  chickModelList.add(chick03);

  int i = 0;
  int fnd = 0;

  chickModelList.forEach((chick) {    
    if(chick.productId==101){
      print("Found 101 ... ${chick.product}");
      //chickModelList.removeAt(i);
	  fnd = i;
    }
	i++;
  });
  
  chickModelList.removeAt(fnd);
  
  print("Full List");
  chickModelList.forEach((chick) {
      print("Item ${chick.product}");
  });
  
}

class ChickModel {
  int productId;
  String product;

  ChickModel(this.productId, this.product);

}
