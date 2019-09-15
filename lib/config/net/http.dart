import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_app_funandroid/utils/platform_utils.dart';
import 'package:flutter_app_funandroid/config/storage_manager.dart';

import 'api.dart';

final Http http = Http();

//对dio 进行封装
//此处拦截了请求，并对请求添加了一些设置
class Http extends Dio{
  static Http instance;

  factory Http(){
    if(instance == null){
      instance = Http._().._init();
    }
    return instance;
  }

  Http._();
  //初始化 加入app通用处理
  _init(){
    //对请求 回应等 变形 见注解
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors
      //基础设置
    ..add(HeaderInterceptor())
    //json处理
    ..add(ApiInterceptor())
    //cookie持久化 异步
    ..add(CookieManager(
      PersistCookieJar(dir: StorageManager.temporaryDirectory.path)
    ));
  }

}


//必须是顶层函数
_parseAndDecode(String response){
  return jsonDecode(response);
}

parseJson(String text){
  //执行完text的操作后，会调用第一个参数 函数
  return compute(_parseAndDecode,text);
}
//添加常用header
//这里对每次请求时，都在请求头 添加了 版本号 和 平台信息
class HeaderInterceptor extends InterceptorsWrapper{

  @override
  onRequest(RequestOptions options) async{
      options.connectTimeout = 1000 * 45;
      options.receiveTimeout = 1000 * 45;

      var appVersion = await PlatformUtils.getAppVersion();
      var version = Map()
        ..addAll({
          'appVerison': appVersion,
        });
      options.headers['version'] = version;
      options.headers['platform'] = PlatformUtils.getPlatform();
      return options;
  }
}
























