class TravelTabModel{
  String url;
  List<TravelTab> tabs;
  Map params;

  TravelTabModel({this.url, this.tabs, this.params});
  factory TravelTabModel.fromJson(Map<String,dynamic> json){
    var dataJson = json['tabs'] as List;
    
    List<TravelTab> data = dataJson.map((i)=> TravelTab.fromJson(i)).toList();
    return TravelTabModel(tabs: data, url: json['url'], params: json['params']);

  }

}

class TravelTab {
  String labelName;
  String groupChannelCode;
  int type;
  
  TravelTab({ this.labelName, this.groupChannelCode, this.type});

  factory TravelTab.fromJson(Map<String, dynamic> json){
    return TravelTab(
      groupChannelCode: json['groupChannelCode'],
      labelName: json['labelName'],
      type: json['type']
      );
  }
}