
import 'package:json_annotation/json_annotation.dart';
part 'app_models.g.dart';


//class Base {
//  bool Status;
//  String Message;
//  bool is_loading;
//
//  Base({this.Status, this.Message, this.is_loading});
//
//  Base buildError(int Errcode, {String message}) {
//    var _h = Base()
//      ..Status = false
//      ..is_loading = false;
//    switch (Errcode) {
//      case 0:
//      //Failed to connect server Error Details:
//        return _h..Message = 'Something went Wrong';
//      case 1:
//        return _h..Message = 'Check your internet connection';
//      case 2:
//        return _h..Message = 'Row and Columns of the seats are not equal';
//      default:
//        return _h..Message = 'HTTP: Status Code ${Errcode}';
//    }
//  }
//}

@JsonSerializable()
class CategrotyModel {
  List<CategrotyData> data;
  bool ApiStatus;
  String Message;
  bool is_loading = false;
  int status;

  CategrotyModel({
      this.ApiStatus,
      this.Message,
      this.is_loading,
      this.status,
      this.data
  });

  factory CategrotyModel.fromJson(Map<String, dynamic> json) =>
      _$CategrotyModelFromJson(json);

}

@JsonSerializable()
class CategrotyData {
  String Name;
  String ProductCode;
  String Category;
  String Tag;
  String ListImage;
  String DescriptionImage;
  String WeightIdentifier;
  int Cost;
  int Stock;
  bool Display;

  CategrotyData({
    this.Name,
    this.ProductCode,
    this.Category,
    this.Tag,
    this.ListImage,
    this.DescriptionImage,
    this.WeightIdentifier,
    this.Cost,
    this.Stock,
    this.Display,
  });

  factory CategrotyData.fromJson(Map<String, dynamic> json) =>
      _$CategrotyDataFromJson(json);
}

@JsonSerializable()
class OrderDetailsModel {
  int status;
  bool is_loading = false;
  List<OrderDetailsData> data;

  OrderDetailsModel({this.status, this.data, this.is_loading});

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsModelFromJson(json);

}

@JsonSerializable()
class OrderDetailsData {
  @JsonKey(name: "_id")
  String id;
  List<OrderCartData> Cart;
  String Name;
  String PhoneNumber;
  String Address;
  String PinCode;
  String DateTime;
  double TotalPrice;
  double Delivery;

  OrderDetailsData({
      this.Cart,
      this.id,
      this.Name,
      this.PhoneNumber,
      this.Address,
      this.PinCode,
      this.DateTime,
      this.TotalPrice,
      this.Delivery});

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsDataFromJson(json);

}

@JsonSerializable()
class OrderCartData {
  String img;
  String VegName;
  String Quantity;
  String Weight;
  String Category;
  double TotalPrice;
  double Cost;
  int stock;
  String ProductId;
  bool Display;

  OrderCartData({
      this.img,
      this.VegName,
      this.Quantity,
      this.Weight,
      this.Category,
      this.TotalPrice,
      this.Cost,
      this.stock,
      this.ProductId,
      this.Display});

  factory OrderCartData.fromJson(Map<String, dynamic> json) =>
      _$OrderCartDataFromJson(json);

}

