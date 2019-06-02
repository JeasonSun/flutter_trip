import 'package:flutter/material.dart';

class SearchItem{
  final String word;
  final String type;
  final String price;
  final String zonename;
  final String districtname;
  final String url;
  final String star;

  SearchItem({this.word, this.type, this.price, this.zonename, this.districtname, @required this.url, this.star});

  factory SearchItem.fromJson(Map<String, dynamic> json){
    return SearchItem(
      word: json['word'],
      type: json['type'],
      price: json['price'],
      zonename: json['zonename'],
      districtname: json['districtname'],
      url: json['url']
    );
  }
}