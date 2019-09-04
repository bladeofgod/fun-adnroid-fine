import 'package:flutter/material.dart';
import 'package:flutter_app_funandroid/config/storage_manager.dart';
import 'package:flutter_app_funandroid/generated/i18n.dart';


class LocalModel extends ChangeNotifier{


  static const localValueList = ['', 'zh-CN', 'en'];
  static const kLocaleIndex = 'kLocaleIndex';


  int _localIndex;

  int get localIndex => _localIndex;

  Locale get locale{
    if(_localIndex >0){
      var value = localValueList[_localIndex].split("-");
      return Locale(value[0],value.length == 2 ? value[0] : '');
    }

    //跟随系统
    return null;
  }

  LocalModel(){
    _localIndex = StorageManager.sharedPreference.get(kLocaleIndex)??0;
  }

  switchLocal(int index){
    _localIndex = index;
    notifyListeners();
    StorageManager.sharedPreference.setInt(kLocaleIndex, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }

}





















