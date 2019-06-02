// 首页网格卡片模型
import 'package:xiecheng/model/common_model.dart';

class GridNavModel {
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel({
    this.hotel,
    this.flight,
    this.travel,
  });

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? GridNavModel(
            hotel: GridNavItem.fromJson(json['hotel']),
            flight: GridNavItem.fromJson(json['flight']),
            travel: GridNavItem.fromJson(json['travel']))
        : null;
  }

  Map< String, dynamic> toJson(){
    return {
      "hotel": hotel?.toJson(),
      "flight": flight?.toJson(),
      "travel": travel?.toJson(),
    };
  }
}

class GridNavItem {
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItem(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
        startColor: json['startColor'],
        endColor: json['endColor'],
        mainItem: CommonModel.fromJson(json['mainItem']),
        item1: CommonModel.fromJson(json['item1']),
        item2: CommonModel.fromJson(json['item2']),
        item3: CommonModel.fromJson(json['item3']),
        item4: CommonModel.fromJson(json['item4']));
  }

  Map<String, dynamic> toJson(){
    return {
      'startColor': startColor,
      'endColor': endColor,
      'mainItem': mainItem?.toJson(),
      'item1': item1?.toJson(),
      'item2': item2?.toJson(),
      'item3': item3?.toJson(),
      'item4': item4?.toJson(),
    };
  }
}
