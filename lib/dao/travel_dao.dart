import 'dart:async';
import 'package:dio/dio.dart';
import 'package:xiecheng/model/travel_model.dart';

const TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031010211161114530&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';


class TravelDao{
  static Future< TravelModel> fetch(
    String url, 
    Map params,
    String groupChannelCode,
    int type,
    int pageIndex,
    int pageSize,

  ) async{
    // Map paramsMap = params['pagePara'];
    params['groupChannelCode'] = groupChannelCode;
    params['type'] = type;
    params['pageIndex'] = pageIndex;
    params['pageSize'] = pageSize;

    Response response = await Dio().post(url, data:params);

    if(response.statusCode == 200){
      return TravelModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}