import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_funandroid/config/provider_manager.dart' ;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_app_funandroid/config/storage_manager.dart';

import 'config/provider_manager.dart';
import 'config/router_config.dart';
import 'generated/i18n.dart';
import 'view_model/local_model.dart';
import 'view_model/theme_model.dart';




void main() async{
  //确保所有widget binding得到运行
  WidgetsFlutterBinding.ensureInitialized();
  //初始化本地配置,eg: 本地路径，sp,local storage等
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //最外层 使用oktoast 详细使用方法 可百度
    return OKToast(
      //multiprovider 同时管理多个状态
      child: MultiProvider(
        //providers 内部当前管理三个状态 theme,local,user
        providers: providers,
        //消费2，标识消费2个状态，还有消费3、消费4.，。
        child: Consumer2<ThemeModel,LocalModel>(
          //构建具体页面同时可以消费provider的数据
          builder: (context,themeModel,localModel,chila){
            return RefreshConfiguration(
              //列表数据不满一页,不触发加载更多
              hideFooterWhenNotFull: true,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeModel.themeData,
                darkTheme: themeModel.darkTheme,
                locale: localModel.locale,
                //国际化
                localizationsDelegates: const[
                  S.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                supportedLocales: S.delegate.supportedLocales,
                onGenerateRoute: Router.generateRoute,
                initialRoute: RouteName.splash,
              ),
            );
          },
        ),

      ),
    );
  }
}




















