import 'package:flutter/material.dart';
import './other.dart';

import './news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('新闻'),
      ),
      body: new News(data: '参数值'),
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
              title: new Text('新闻'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/a');
              },
            ),
            new ListTile(
              title: new Text('每日一笑'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new OtherPage('每日一笑')));
              },
            ),
            new ListTile(
              title: new Text('Second Page'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new OtherPage('2222222222222222')));
              },
            ),
           
          ],
        ),
      ),
    );
  }
}
