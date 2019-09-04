

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter_app_funandroid/model/article.dart';
import 'package:flutter_app_funandroid/model/tree.dart';
import 'package:flutter_app_funandroid/ui/page/favourite_list_page.dart';
import 'package:flutter_app_funandroid/ui/page/article_list_page.dart';
import 'package:flutter_app_funandroid/ui/page/setting_page.dart';
import 'package:flutter_app_funandroid/ui/page/tab/home_second_floor_page.dart';
import 'package:flutter_app_funandroid/ui/page/tab/tab_navigator.dart';
import 'package:flutter_app_funandroid/ui/page/user/login_page.dart';
import 'package:flutter_app_funandroid/ui/page/splash.dart';
import 'package:flutter_app_funandroid/ui/page/article_detail_page.dart';
import 'package:flutter_app_funandroid/ui/page/user/register_page.dart';
import 'package:flutter_app_funandroid/ui/widget/page_route_anim.dart';

/*
* 项目 route
*
* */

class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String homeSecondFloor = 'homeSecondFloor';
  static const String login = 'login';
  static const String register = 'register';
  static const String articleDetail = 'articleDetail';
  static const String treeList = 'treeList';
  static const String collectionList = 'collectionList';
  static const String setting = 'setting';
}


class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){}
  }
}




























