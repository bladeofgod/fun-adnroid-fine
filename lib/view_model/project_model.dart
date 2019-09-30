import 'package:flutter_app_funandroid/model/article.dart';
import 'package:flutter_app_funandroid/model/tree.dart';
import 'package:flutter_app_funandroid/provider/view_state_refresh_list_model.dart';
import 'package:flutter_app_funandroid/provider/view_state_list_model.dart';
import 'package:flutter_app_funandroid/service/wan_android_repository.dart';



class ProjectCategoryModel extends ViewStateListModel<Tree>{
  @override
  Future<List<Tree>> loadData() async{
    // TODO: implement loadData
    return await WanAndroidRepository.fetchProjectCategories();
  }


}


class ProjectListModel extends ViewStateRefreshListModel<Article>{
  @override
  Future<List<Article>> loadData({int pageNum}) async{
    // TODO: implement loadData
    return await WanAndroidRepository.fetchArticles(pageNum,cid:294);
  }

}
























