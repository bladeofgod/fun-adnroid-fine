import 'package:flutter/material.dart';

/*
* 首页滚动时 悬浮按钮的变化
* */
class TapTopModel with ChangeNotifier{


  ScrollController _scrollController;

  double _height;

  bool _showTopBtn = false;

  ScrollController get scrollController => _scrollController;

  bool get showTopBtn => _showTopBtn;

  TapTopModel(this._scrollController,{double height:200}){
    _height = height;
  }

  init(){
    _scrollController.addListener((){
      if(_scrollController.offset > _height && !_showTopBtn){
        //滚动距离大于 height 显示 到顶部按钮
        _showTopBtn = true;
        notifyListeners();
      }else if(_scrollController.offset < _height &&  _showTopBtn){
        _showTopBtn = false;
        notifyListeners();
      }
    });
  }

  scrollToTop(){
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic);
  }

}













