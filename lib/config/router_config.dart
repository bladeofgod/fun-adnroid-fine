

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
    switch(settings.name){
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.homeSecondFloor:
        return SlideTopRouteBuilder(MyBlogPage());
      case RouteName.login:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
      case RouteName.articleDetail:
        var article = settings.arguments as Article;
        return CupertinoPageRoute(
            builder: (_) => ArticleDetailPage(
              article: article,
            ));
      case RouteName.treeList:
        var list = settings.arguments as List;
        Tree tree = list[0] as Tree;
        int index = list[1];
        return CupertinoPageRoute(
            builder: (_) => ArticleCategoryTabPage(tree, index));
      case RouteName.collectionList:
        return CupertinoPageRoute(builder: (_) => FavouriteListPage());
      case RouteName.setting:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}

/// Pop路由
/// 可以弹出透明背景的布局，类似popup window
  class PopRoute extends PopupRoute{

  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  // TODO: implement barrierColor
  Color get barrierColor => null;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return child;
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => _duration;

  }




























