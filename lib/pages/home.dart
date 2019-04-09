import 'package:flutter/material.dart';
import './other.dart';

import './TopTabPages/TopTabPage_1.dart';
import './TopTabPages/TopTabPage_2.dart';
import './TopTabPages/TopTabPage_3.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _bottomTabs = <Tab>[
    new Tab(text: 'Home',icon: new Icon(Icons.home),),    //icon和text的显示顺序已经内定，如需自定义，到child属性里面加吧
    new Tab(icon: new Icon(Icons.history),text: 'History',),
    new Tab(icon: new Icon(Icons.book),text: 'Book',),
  ];
  TabController _bottomNavigation;
  @override
  void initState() {
    super.initState();
    _bottomNavigation =
        new TabController(vsync: this, length: _bottomTabs.length);
  }

  @override
  void dispose() {
    _bottomNavigation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('新闻'),
      ),
      body: new TabBarView(controller: _bottomNavigation, children: [
        new News(data: '参数值'),
        new TabPage2(),
        new TabPage3(),
      ]),
      bottomNavigationBar: new Material(
        color: Colors.blueAccent, //底部导航栏主题颜色
        child: new TabBar(
          controller: _bottomNavigation,
          tabs: _bottomTabs,
          indicatorColor: Colors.white, //tab标签的下划线颜色
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('从入门到进错门',
                  style: new TextStyle(color: Colors.pink[500])),
              accountEmail: new Text('example@111.com'),
              currentAccountPicture: new GestureDetector(
                onTap: () => print('current user'),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3523617831,1288544462&fm=27&gp=0.jpg'),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new ExactAssetImage('imgs/bg.jpg')),
              ),
            ),
            new ListTile(
              title: new Text('First Page'),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new OtherPage('1111111111111111')));
              },
            ),
            new ListTile(
              title: new Text('Second Page'),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new OtherPage('2222222222222222')));
              },
            ),
            new ListTile(
              title: new Text('th Page'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/a');
              },
            )
          ],
        ),
      ),
    );
  }
}
