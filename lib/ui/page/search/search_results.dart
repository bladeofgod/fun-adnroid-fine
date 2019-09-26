import 'package:flutter/material.dart';
import 'package:flutter_app_funandroid/provider/provider_widget.dart';
import 'package:flutter_app_funandroid/ui/helper/refresh_helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_app_funandroid/model/article.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_funandroid/ui/widget/article_list_Item.dart';
import 'package:flutter_app_funandroid/provider/view_state_widget.dart';
import 'package:flutter_app_funandroid/view_model/search_model.dart';


class SearchResult extends StatelessWidget{

  final String keyWord;
  final SearchHistoryModel searchHistoryModel;

  SearchResult({this.keyWord,this.searchHistoryModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<SearchResultModel>(
      model: SearchResultModel(
        keyword:keyWord,searchHistoryModel:searchHistoryModel
      ),
      onModelReady: (model){
        model.initData();
      },
      builder: (context,model,child){
        if(model.busy){
          return ViewStateBusyWidget();
        }else if(model.error){
          return ViewStateWidget(onPressed: model.initData(),);
        }else if(model.empty){
          return ViewStateEmptyWidget(onPressed: model.initData(),);
        }
        return SmartRefresher(
          controller: model.refreshController,
          header: WaterDropHeader(),
          footer: RefresherFooter(),
          onLoading: model.loadMore,
          onRefresh: model.refresh,
          enablePullUp: true,
          child: ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context,index){
              Article item = model.list[index];
              return ArticleItemWidget(item);
            },
          ),
        );
      },
    );
  }

}



















