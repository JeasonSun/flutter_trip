import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xiecheng/model/common_model.dart';
import 'package:xiecheng/model/sales_box_model.dart';
import 'package:xiecheng/widget/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Widget> children = [];
    // children.add(value)
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            margin: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                salesBox != null
                    ? Image.network(
                        salesBox.icon,
                        height: 15,
                        fit: BoxFit.fill,
                      )
                    : null,
                Container(
                  padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                          colors: [Color(0xffff4e63), Color(0xffff6cc9)])),
                  child: Text(
                    '获取更多福利>',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          ),
          _doubleItem(
              context, salesBox.bigCard1, salesBox.bigCard2, true, false),
          _doubleItem(
              context, salesBox.smallCard1, salesBox.smallCard2, false, false),
          _doubleItem(
              context, salesBox.smallCard3, salesBox.smallCard4, false, true),
        ],
      ),
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context, leftCard, true, big, last),
        _item(context, rightCard, true, big, last)
      ],
    );
  }

  Widget _item(
      BuildContext context, CommonModel model, bool left, bool big, bool last) {
        BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfffff2f2));
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: model.url,
                        statusBarColor: model.statusBarColor,
                        hideAppBar: model.hideAppBar,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: left?borderSide: BorderSide.none, bottom: last?BorderSide.none: borderSide)
          ),
          child: Image.network(
            model.icon,
            fit:BoxFit.fill,
            width: MediaQuery.of(context).size.width - 5,
            height: big ? 129 : 80,
          ),
        ),
      ),
    );
  }
}
