import 'package:flutter_app_funandroid/model/article.dart';
import 'package:flutter_app_funandroid/provider/view_state_refresh_list_model.dart';
import 'package:flutter_app_funandroid/provider/view_state_model.dart';
import 'package:flutter_app_funandroid/service/wan_android_repository.dart';

import 'login_model.dart';

//我的收藏列表

class FavouriteListModel extends ViewStateRefreshListModel<Article>{

  LoginModel loginModel;

  FavouriteListModel({this.loginModel});

  @override
  void setUnAuthorized() {
    // TODO: implement setUnAuthorized
    loginModel.logout();
    super.setUnAuthorized();
  }

  @override
  Future<List<Article>> loadData({int pageNum}) async{
    // TODO: implement loadData
    return await WanAndroidRepository.fetchCollectList(pageNum);
  }

}
//收藏/取消收藏

class FavouriteModel extends ViewStateModel{
  final Article article;

  FavouriteModel(this.article);

  collect()async{
    setBusy(true);
    try{
      if(article.collect == null){
        await WanAndroidRepository.unMyCollect(
          id:article.id,originId:article.originId
        );
      }else{
        if(article.collect){
          await WanAndroidRepository.unCollect(article.id);
        }else{
          await WanAndroidRepository.collect(article.id);
        }
      }
      article.collect = !(article.collect ?? true);
      setBusy(false);
    }catch(e, s) {
      handleCatch(e, s);
    }
  }

}













