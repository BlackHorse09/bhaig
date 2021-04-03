
import 'package:json_annotation/json_annotation.dart';
part 'app_models.g.dart';


class Base {
  int status;
  String Message;
  bool is_loading;

  Base({this.status, this.Message, this.is_loading});

  Base buildError(int Errcode, {String message}) {
    var _h = Base()
      ..status = 500
      ..is_loading = false;
    switch (Errcode) {
      case 0:
      //Failed to connect server Error Details:
        return _h..Message = 'Something went Wrong';
      case 1:
        return _h..Message = 'Check your internet connection';
      case 2:
        return _h..Message = 'Row and Columns of the seats are not equal';
      default:
        return _h..Message = 'HTTP: Status Code ${Errcode}';
    }
  }
}

@JsonSerializable()
class CategrotyModel extends Base {
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

  static CategrotyModel buildErr(int Errcode, {String message}) {
    CategrotyModel res_d = CategrotyModel();
    Base _b = res_d.buildError(Errcode, message: message);
    return res_d
      ..Message = _b.Message
      ..status = _b.status
      ..is_loading = _b.is_loading;
  }

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
  double Cost;
  double Stock;
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
class HomePageModel extends Base {
  int status;
  HomePageModelData data;
  bool is_loading;
  String Message;

  HomePageModel({this.status, this.data, this.is_loading, this.Message});

  factory HomePageModel.fromJson(Map<String, dynamic> json) =>
      _$HomePageModelFromJson(json);

  static HomePageModel buildErr(int Errcode, {String message}) {
    HomePageModel res_d = HomePageModel();
    Base _b = res_d.buildError(Errcode, message: message);
    return res_d
      ..Message = _b.Message
      ..status = _b.status
      ..is_loading = _b.is_loading;
  }

}

@JsonSerializable()
class HomePageModelData {
  String PincodeList;
  String StartTime;
  String EndTime;
  String ContactUsInfo;
  String EnterpriseName;
  double MinimumCost;
  double DeliveryCharges;

  HomePageModelData({
    
      this.PincodeList,
      this.StartTime,
      this.EndTime,
      this.ContactUsInfo,
      this.EnterpriseName,
      this.MinimumCost,
      this.DeliveryCharges});

  factory HomePageModelData.fromJson(Map<String, dynamic> json) =>
      _$HomePageModelDataFromJson(json);

}