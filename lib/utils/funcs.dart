import 'package:intl/intl.dart';

class Funcs{

  static String currentDateAsStr(){
    /* Returns current date as format */
    var now = DateTime.now();
    return DateFormat("dd/mm/yyyy HH:mm:ss").format(now);
  }

  
}