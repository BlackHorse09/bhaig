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
    Cost: json['Cost'] as int,
    Stock: json['Stock'] as int,
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

OrderDetailsModel _$OrderDetailsModelFromJson(Map<String, dynamic> json) {
  return OrderDetailsModel(
    status: json['status'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : OrderDetailsData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    is_loading: json['is_loading'] as bool,
  );
}

Map<String, dynamic> _$OrderDetailsModelToJson(OrderDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_loading': instance.is_loading,
      'data': instance.data,
    };

OrderDetailsData _$OrderDetailsDataFromJson(Map<String, dynamic> json) {
  return OrderDetailsData(
    Cart: (json['Cart'] as List)
        ?.map((e) => e == null
            ? null
            : OrderCartData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['_id'] as String,
    Name: json['Name'] as String,
    PhoneNumber: json['PhoneNumber'] as String,
    Address: json['Address'] as String,
    PinCode: json['PinCode'] as String,
    DateTime: json['DateTime'] as String,
    TotalPrice: (json['TotalPrice'] as num)?.toDouble(),
    Delivery: (json['Delivery'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OrderDetailsDataToJson(OrderDetailsData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'Cart': instance.Cart,
      'Name': instance.Name,
      'PhoneNumber': instance.PhoneNumber,
      'Address': instance.Address,
      'PinCode': instance.PinCode,
      'DateTime': instance.DateTime,
      'TotalPrice': instance.TotalPrice,
      'Delivery': instance.Delivery,
    };

OrderCartData _$OrderCartDataFromJson(Map<String, dynamic> json) {
  return OrderCartData(
    img: json['img'] as String,
    VegName: json['VegName'] as String,
    Quantity: json['Quantity'] as String,
    Weight: json['Weight'] as String,
    Category: json['Category'] as String,
    TotalPrice: (json['TotalPrice'] as num)?.toDouble(),
    Cost: (json['Cost'] as num)?.toDouble(),
    stock: json['stock'] as int,
    ProductId: json['ProductId'] as String,
    Display: json['Display'] as bool,
  );
}

Map<String, dynamic> _$OrderCartDataToJson(OrderCartData instance) =>
    <String, dynamic>{
      'img': instance.img,
      'VegName': instance.VegName,
      'Quantity': instance.Quantity,
      'Weight': instance.Weight,
      'Category': instance.Category,
      'TotalPrice': instance.TotalPrice,
      'Cost': instance.Cost,
      'stock': instance.stock,
      'ProductId': instance.ProductId,
      'Display': instance.Display,
    };
