import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageManager{
  /// app全局配置 eg:theme
  static SharedPreferences sharedPreference;

  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;

/// 初始化必备操作 eg:user数据
  static LocalStorage localStorage;


  static init() async{
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreference = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}






















