
import 'package:xiecheng/model/search_item.dart';

class SearchModel {
  final String keyword;
  final List<SearchItem> data;

  SearchModel({this.data, this.keyword});

  factory SearchModel.fromJson(Map<String, dynamic> json, String keyword){
    var dataJson = json['data'] as List;
    List<SearchItem> data = dataJson.map((i)=> SearchItem.fromJson(i)).toList();
    return SearchModel(data: data, keyword: keyword);
  }
  
}