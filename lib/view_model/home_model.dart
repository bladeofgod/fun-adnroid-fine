import 'package:flutter_app_funandroid/model/article.dart';
import 'package:flutter_app_funandroid/model/banner.dart';
import 'package:flutter_app_funandroid/provider/view_state_refresh_list_model.dart';
import 'package:flutter_app_funandroid/service/wan_android_repository.dart';


///首页 VM

class HomeModel extends ViewStateRefreshListModel{

  List<Banner> _banners;
  List<Article> _topArticles;


  List<Banner> get banners => _banners;
  List<Article> get topArticles => _topArticles;

  @override
  Future<List> loadData({int pageNum}) async {
    // TODO: implement loadData
    List<Future> futures = [];
    if(pageNum == ViewStateRefreshListModel.pageNumFirst){
      futures.add(WanAndroidRepository.fetchBanners());
      futures.add(WanAndroidRepository.fetchTopArticle());
    }
    futures.add(WanAndroidRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if(pageNum == ViewStateRefreshListModel.pageNumFirst){
      _banners = result[0];
      _topArticles = result[1];
      return result[2];
    }else {
      return result[0];
    }
  }

}



















