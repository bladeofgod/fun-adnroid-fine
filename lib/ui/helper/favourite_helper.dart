import 'package:flutter/cupertino.dart';
import 'package:flutter_app_funandroid/config/router_config.dart';
import 'package:flutter_app_funandroid/generated/i18n.dart';
import 'package:flutter_app_funandroid/ui/widget/favourite_animation.dart';
import 'package:flutter_app_funandroid/config/resource_namager.dart';
import 'package:flutter_app_funandroid/config/router_config.dart';
import 'package:flutter_app_funandroid/model/article.dart';
import 'package:flutter_app_funandroid/provider/provider_widget.dart';
import 'package:flutter_app_funandroid/view_model/favourite_model.dart';
import 'package:oktoast/oktoast.dart';

import 'dialog_helper.dart';


/// 收藏文章.
/// 如果用户未登录,需要跳转到登录界面
/// 如果执行失败,需要给与提示
///
/// 由于存在递归操作,所以抽取为方法,而且多处调用
/// 多个页面使用该方法,目前这种方式并不优雅,抽取位置有待商榷
///
///

addFavourites(context,model, tag, {playAnim:true})async{
  await model.collect();

  //未登录
  if(model.unAuthorized){
    if(await DialogHelper.showLoginDialog(context)){
      var success = await Navigator.pushNamed(context, RouteName.login);
      if(success ?? false){
        addFavourites(context, model, tag);
      }
    }else if(model.error){
      //失败
      showToast(S.of(context).loadFailed);
    }else {
      if(playAnim){
        //接口调用成功播放动画
        Navigator.push(context,
        HeroDialogRoute(
          builder:(_)=>FavouriteAnimationWidget(
            tag: tag,
            add: model.article.collect,
          )
        ));
      }
    }
  }

}



















