// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategrotyModel _$CategrotyModelFromJson(Map<String, dynamic> json) {
  return CategrotyModel(
    ApiStatus: json['ApiStatus'] as bool,
    Message: json['Message'] as String,
    is_loading: json['is_loading'] as bool,
    status: json['status'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CategrotyData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategrotyModelToJson(CategrotyModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'ApiStatus': instance.ApiStatus,
      'Message': instance.Message,
      'is_loading': instance.is_loading,
      'status': instance.status,
    };

CategrotyData _$CategrotyDataFromJson(Map<String, dynamic> json) {
  return CategrotyData(
    Name: json['Name'] as String,
    ProductCode: json['ProductCode'] as String,
    Category: json['Category'] as String,
    Tag: json['Tag'] as String,
    ListImage: json['ListImage'] as String,
    DescriptionImage: json['DescriptionImage'] as String,
    WeightIdentifier: json['WeightIdentifier'] as String,
    Cost: (json['Cost'] as num)?.toDouble(),
    Stock: (json['Stock'] as num)?.toDouble(),
    Display: json['Display'] as bool,
  );
}

Map<String, dynamic> _$CategrotyDataToJson(CategrotyData instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'ProductCode': instance.ProductCode,
      'Category': instance.Category,
      'Tag': instance.Tag,
      'ListImage': instance.ListImage,
      'DescriptionImage': instance.DescriptionImage,
      'WeightIdentifier': instance.WeightIdentifier,
      'Cost': instance.Cost,
      'Stock': instance.Stock,
      'Display': instance.Display,
    };

HomePageModel _$HomePageModelFromJson(Map<String, dynamic> json) {
  return HomePageModel(
    status: json['status'] as int,
    data: json['data'] == null
        ? null
        : HomePageModelData.fromJson(json['data'] as Map<String, dynamic>),
    is_loading: json['is_loading'] as bool,
    Message: json['Message'] as String,
  );
}

Map<String, dynamic> _$HomePageModelToJson(HomePageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'is_loading': instance.is_loading,
      'Message': instance.Message,
    };

HomePageModelData _$HomePageModelDataFromJson(Map<String, dynamic> json) {
  return HomePageModelData(
    PincodeList: json['PincodeList'] as String,
    StartTime: json['StartTime'] as String,
    EndTime: json['EndTime'] as String,
    ContactUsInfo: json['ContactUsInfo'] as String,
    EnterpriseName: json['EnterpriseName'] as String,
    MinimumCost: (json['MinimumCost'] as num)?.toDouble(),
    DeliveryCharges: (json['DeliveryCharges'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HomePageModelDataToJson(HomePageModelData instance) =>
    <String, dynamic>{
      'PincodeList': instance.PincodeList,
      'StartTime': instance.StartTime,
      'EndTime': instance.EndTime,
      'ContactUsInfo': instance.ContactUsInfo,
      'EnterpriseName': instance.EnterpriseName,
      'MinimumCost': instance.MinimumCost,
      'DeliveryCharges': instance.DeliveryCharges,
    };
