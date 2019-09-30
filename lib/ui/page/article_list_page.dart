
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_funandroid/ui/helper/refresh_helper.dart';
import 'package:flutter_app_funandroid/ui/widget/article_skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_app_funandroid/model/article.dart';
import 'package:flutter_app_funandroid/model/tree.dart';
import 'package:flutter_app_funandroid/provider/provider_widget.dart';
import 'package:flutter_app_funandroid/provider/view_state_widget.dart';
import 'package:flutter_app_funandroid/ui/widget/article_list_Item.dart';
import 'package:flutter_app_funandroid/view_model/structure_model.dart';



/// 文章列表页面

class ArticleListPage extends StatefulWidget{

  final int cid;

  /// 目录id
  ArticleListPage(this.cid);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticleListPageState();
  }

}

class ArticleListPageState extends State<ArticleListPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<StructureListModel>(
      model: StructureListModel(widget.cid),
      onModelReady: (model){
        model.initData();
      },
      builder: (context,model,child){
        if(model.busy){
          return ViewStateSkeletonList(
            builder: (context,index) => ArticleSkeletonItem(),
          );
        }else if(model.error){}
      },
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}






























