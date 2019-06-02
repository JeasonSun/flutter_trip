import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng/dao/home_dao.dart';
import 'package:xiecheng/model/grid_nav_model.dart';
import 'package:xiecheng/model/home_model.dart';
import 'package:xiecheng/model/common_model.dart';
import 'package:xiecheng/model/sales_box_model.dart';
import 'package:xiecheng/pages/search_page.dart';
import 'package:xiecheng/widget/grid_nav.dart';
import 'package:xiecheng/widget/loading_container.dart';

import 'package:xiecheng/widget/local_nav.dart';
import 'package:xiecheng/widget/sales_box.dart';
import 'package:xiecheng/widget/search_bar.dart';
import 'package:xiecheng/widget/sub_nav.dart';

const CITY_NAMES = ['北京', '上海', '广州', '江苏'];
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final APPBAR_SCROLL_OFFSET = 100;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;
  bool _isLoading = false;

  double appBarAlpha = 0;

  _onListViewScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha > 1) {
      alpha = 1;
    } else if (alpha < 0) {
      alpha = 0;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _isLoading,
        cover: false, // cover为false,底为白色 + loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _loadData,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      // 滚动且是列表滚动的时候
                      _onListViewScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 200,
                        child: Swiper(
                          itemCount: bannerList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(bannerList[index].icon,
                                fit: BoxFit.fill);
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(
                          localNavList: localNavList,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: GridNav(gridNavModel: gridNavModel),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: SubNav(
                          subNavList: subNavList,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: SalesBox(
                          salesBox: salesBox,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _appBar,
          ],
        ),
      ),
    );
  }

  Future<Null> _loadData() async {
    try {
      _isLoading = true;
      HomeModel homemodel = await HomeDao.fetch();
      setState(() {
        localNavList = homemodel.localNavList;
        gridNavModel = homemodel.gridNav;
        subNavList = homemodel.subNavList;
        salesBox = homemodel.salesBox;
        bannerList = homemodel.bannerList;
        _isLoading = false;
      });
    } catch (e) {
      _isLoading = false;
      print(e);
    }
    return null;
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 1 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  _jumpToSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return SearchPage(hideLeft: false, hint:SEARCH_BAR_DEFAULT_TEXT);
    }));
  }
  _jumpToSpeak() {}
}
