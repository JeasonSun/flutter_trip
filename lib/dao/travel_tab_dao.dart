import 'package:xiecheng/model/travle_tab_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const TRAVELTABURL = 'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/travel_page.json';
class TravelTabDao{
  static Future< TravelTabModel> fetch() async{
    print('fetch travel tab model');
    final response = await http.get(TRAVELTABURL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travle_tab.json');
    }
  }
}