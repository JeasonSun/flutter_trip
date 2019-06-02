import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiecheng/model/common_model.dart';
import 'package:xiecheng/model/grid_nav_model.dart';
import 'package:xiecheng/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;
  final String name;

  const GridNav({Key key, @required this.gridNavModel, this.name = 'Jeason'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) {
      return items;
    }
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });

    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              margin: EdgeInsets.only(top: 11),
            )
          ],
        ),
        model);
  }

  _doubleItem(
    BuildContext context,
    CommonModel topItem,
    CommonModel bottomItem,
  ) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    final BorderSide borderSide = BorderSide(color: Colors.white, width: 0.8);
    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
            child: _wrapGesture(
                context,
                Center(
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                item),
            decoration: BoxDecoration(
                border: Border(
                    left: borderSide,
                    bottom: first ? borderSide : BorderSide.none))));
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: model.url,
                      statusBarColor: model.statusBarColor,
                      title: model.title,
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
