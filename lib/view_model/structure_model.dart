import 'package:flutter_app_funandroid/provider/view_state_refresh_list_model.dart';
import 'package:flutter_app_funandroid/provider/view_state_list_model.dart';
import 'package:flutter_app_funandroid/provider/view_state_widget.dart';
import 'package:flutter_app_funandroid/service/wan_android_repository.dart';



class StructureCategoryModel extends ViewStateListModel{
  @override
  Future<List> loadData() async{
    // TODO: implement loadData
    return WanAndroidRepository.fetchTreeCategories();
  }

}


class StructureListModel extends ViewStateRefreshListModel{

  final int cid;

  StructureListModel(this.cid);

  @override
  Future<List> loadData({int pageNum})async {
    // TODO: implement loadData
    return await WanAndroidRepository.fetchArticles(pageNum,cid: cid);
  }

}

/// 网址导航
class NavigationSiteModel extends ViewStateListModel{
  @override
  Future<List> loadData()  async{
    // TODO: implement loadData
    return await WanAndroidRepository.fetchNavigationSite();
  }

}
















