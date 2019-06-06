import 'package:xiecheng/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const HOME_URL = 'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/home_page.json';
// const HOME_URL ="http://www.devio.org/io/flutter_app/json/travel_page.json";

class HomeDao{
  static Future<HomeModel> fetch() async{
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print(response);
      return HomeModel.fromJson(result);
    } else{
      throw Exception('Failed to load home_page.json');
    }
  } 
}