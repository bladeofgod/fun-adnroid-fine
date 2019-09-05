import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_funandroid/generated/i18n.dart';

import 'home_page.dart';
import 'project_page.dart';
import 'structure_page.dart';
import 'user_page.dart';
import 'wechat_account_page.dart';



class TabNavigator extends StatefulWidget{

  TabNavigator({Key key}): super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabNavigatorState();
  }

}


List<Widget> pages = <Widget>[
  HomePage(),
  ProjectPage(),
  WechatAccountPage(),
  StructurePage(),
  UserPage()
];

class TabNavigatorState extends State<TabNavigator> {

  var _pageController = PageController();

  int _selectIndex=  0;
  DateTime _lastPressed;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          if(_lastPressed == null ||
          DateTime.now().difference(_lastPressed) > Duration(seconds: 1)){
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;

          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx,index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index){
            setState(() {
              _selectIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            title:Text(S.of(context).tabHome)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(S.of(context).tabProject),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            title: Text(S.of(context).wechatAccount),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            title: Text(S.of(context).tabStructure),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            title: Text(S.of(context).tabUser),
          ),
        ],
        currentIndex: _selectIndex,
        onTap: (index){
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}





















