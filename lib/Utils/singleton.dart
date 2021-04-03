
class AAAppSingleton {
  static final AAAppSingleton _singleton = new AAAppSingleton._internal();

  var addCartObj = [];
  double totalCartAmount = 0.0;
  bool enablePayment = false;
  double minimumCost = 0.0;
  List<String> pincodeList = [];
  bool isAllowed = true;
  double deliveryCharges = 0.0;
  String cmpanyName = "Nirmal Enterprises";
  int billId = 0;

  bool isTimeUp;
  String start;
  String end;


  factory AAAppSingleton() {
    return _singleton;
  }

  AAAppSingleton._internal();
}