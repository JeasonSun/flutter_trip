import 'package:xiecheng/model/common_model.dart';
import 'package:xiecheng/model/config_model.dart';
import 'package:xiecheng/model/grid_nav_model.dart';
import 'package:xiecheng/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.salesBox,
      this.subNavList});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
        localNavList: localNavList,
        bannerList: bannerList,
        subNavList: subNavList,
        config: ConfigModel.fromJson(json['config']),
        gridNav: GridNavModel.fromJson(json['gridNav']),
        salesBox: SalesBoxModel.fromJson(json['salesBox']),
        );
  }

  Map<String, dynamic> toJson(){
    return {
      'config': config.toJson(),
      'gridNav': gridNav.toJson(),
      'salesBox': salesBox.toJson(),
      'bannerList': bannerList.map((i) => i.toJson()).toList(),
      'localNavList': localNavList.map((i)=> i.toJson()).toList(),
      'subNavList': subNavList.map((i)=> i.toJson()).toList()
    };
  }
}
