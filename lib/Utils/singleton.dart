
class AAAppSingleton {
  static final AAAppSingleton _singleton = new AAAppSingleton._internal();

  var addCartObj = [];
  double totalCartAmount = 0.0;
  bool enablePayment = false;

  factory AAAppSingleton() {
    return _singleton;
  }

  AAAppSingleton._internal();
}