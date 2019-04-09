import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

int currentTimeMillis() {
  return new DateTime.now().millisecondsSinceEpoch;
}

class OtherPage extends StatelessWidget {
  final String pageText;
  OtherPage(this.pageText);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(pageText),
      ),
      body: new Center(
        child: new LaughList(),
      ),
    );
  }
}

//新闻列表
class LaughList extends StatefulWidget {
  final String newsType; //新闻类型
  @override
  LaughList({Key key, this.newsType}) : super(key: key);

  _LaughListState createState() => new _LaughListState();
}

class _LaughListState extends State<LaughList> {
  final String _url = 'http://v.juhe.cn/joke/content/list.php';
  final String _time = currentTimeMillis().toString().substring(0, 10);
  List data;
  
  //HTTP请求的函数返回值为异步控件Future
  Future<String> get() async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(
        '${_url}?sort=desc&page=&pagesize=&time=${_time}&key=87bf8a84dd4b3daafa1cea4f8b46cac7'));
    var response = await request.close();
    return await response.transform(utf8.decoder).join();
  }

  Future<Null> loadData() async {
    await get(); //注意await关键字
    if (!mounted) return; //异步处理，防止报错
    setState(() {}); //什么都不做，只为触发RefreshIndicator的子控件刷新
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: new FutureBuilder(
        //用于懒加载的FutureBuilder对象
        future: get(), //HTTP请求获取数据，将被AsyncSnapshot对象监视
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: //get未执行时
            case ConnectionState.waiting: //get正在执行时
              return new Center(
                child: new Card(
                  child: new Text('loading...'), //在页面中央显示正在加载
                ),
              );
            default:
              if (snapshot.hasError) //get执行完成但出现异常
                return new Text('Error: ${snapshot.error}');
              else //get正常执行完成
                // 创建列表，列表数据来源于snapshot的返回值，而snapshot就是get(widget.newsType)执行完毕时的快照
                // get(widget.newsType)执行完毕时的快照即函数最后的返回值。
                return createListView(context, snapshot);
          }
        },
      ),
      onRefresh: loadData,
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    // print(snapshot.data);
    List values;
    values = jsonDecode(snapshot.data)['result'] != null
        ? jsonDecode(snapshot.data)['result']['data']
        : [''];
    switch (values.length) {
      case 1: //没有获取到数据，则返回请求失败的原因
        return new Center(
          child: new Card(
            child: new Text(jsonDecode(snapshot.data)['reason']),
          ),
        );
      default:
        return new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            // itemCount: data == null ? 0 : data.length,
            itemCount: values == null ? 0 : values.length,
            itemBuilder: (context, i) {
              // return _newsRow(data[i]);//把数据项塞入ListView中
              return _newsRow(values[i]);
            });
    }
  }

  //新闻列表单个item
  Widget _newsRow(newsInfo) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new ListTile(
              title: new Text(
                newsInfo["content"],
                textScaleFactor: 1.0,
              ),
            ),
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          ),
          new Container(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(
                    child: new Text(newsInfo["updatetime"]),
                  ),
                  // new Expanded(
                  //   child: new Text(newsInfo["date"]),
                  // ),
                ],
              )),
        ],
      ),
    );
  }
}
