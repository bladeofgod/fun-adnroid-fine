import 'package:flutter/material.dart' hide Banner ,showSearch;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app_funandroid/provider/view_state_widget.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app_funandroid/generated/i18n.dart';
import 'package:flutter_app_funandroid/ui/helper/refresh_helper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_app_funandroid/config/router_config.dart';
import 'package:flutter_app_funandroid/flutter/search.dart'; //修改flutter库的源文件
import 'package:flutter_app_funandroid/model/article.dart';
import 'package:flutter_app_funandroid/provider/provider_widget.dart';
import 'package:flutter_app_funandroid/view_model/scroll_controller_model.dart';
import 'package:flutter_app_funandroid/ui/widget/animated_provider.dart';
import 'package:flutter_app_funandroid/ui/widget/banner_image.dart';
import 'package:flutter_app_funandroid/provider/view_state_model.dart';
import 'package:flutter_app_funandroid/ui/widget/article_list_Item.dart';
import 'package:flutter_app_funandroid/ui/widget/article_skeleton.dart';
import 'package:flutter_app_funandroid/view_model/home_model.dart';
import 'package:flutter_app_funandroid/ui/page/search/search_delegate.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    ///看了一下 源码 貌似没必要
    super.build(context);
    // TODO: implement build
    var size  = MediaQuery.of(context).size;

    /// iPhoneX 头部适配
    var top = MediaQuery.of(context).padding.top;
    var bannerHeight = size.width * 9/16 - top;
    ///ProviderWidget2为封装类，对provider进行了封装
    ///其本质类似 MVP 中P，内部对model进行加载，并提供给 builder和child消费

    return ProviderWidget2<HomeModel,TapTopModel>(
      model1: HomeModel(),
      // 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
      model2: TapTopModel(PrimaryScrollController.of(context),
                  height: bannerHeight - kToolbarHeight),
      onModelReady: (homeModel,tapTopModel){
        homeModel.initData();
        tapTopModel.init();
      },
      //根据home model 的状态返回不同的Widget， 这里的homemodel 就是通过外层的provider 提供的
      builder: (context,homeModel,tapTopModel,child){
        //构造整体的页面，2个model 对 页面构造提供具体的数据
        return Scaffold(
          //解决listview 顶部padding问题，具体可以百度
          body: MediaQuery.removePadding(
              context: context,
              removeTop: false, //true 移除顶部padding
              child: Builder(
                builder: (_){
                  if(homeModel.error){
                    return ViewStateWidget(onPressed: homeModel.initData(),);
                  }
                  //RefreshConfiguration.copyAncestor 从父类获取到属性设置（这里应该是main
                  // app那里的设置）
                  return RefreshConfiguration.copyAncestor(
                      context: context,
                      // 下拉触发二楼距离
                      twiceTriggerDistance: kHomeRefreshHeight - 15,
                      //最大下拉距离,android默认为0,这里为了触发二楼
                      maxOverScrollExtent: kHomeRefreshHeight,
                      child: SmartRefresher(
                          enableTwoLevel: true,
                        controller: homeModel.refreshController,
                        header: HomeRefreshHeader(),
                        ///二层楼
                        onTwoLevel: ()async{
                            await Navigator.of(context)
                                .pushNamed(RouteName.homeSecondFloor);
                            await Future.delayed(Duration(milliseconds: 300));
                            Provider.of<HomeModel>(context)
                            // of后返回一个model，并调用下面的方法
                                    .refreshController
                                    .twoLevelComplete();
                        },
                        footer: RefresherFooter(),
                        onRefresh: homeModel.refresh,
                        onLoading: homeModel.loadMore,
                        enablePullUp: true,
                        child: CustomScrollView(
                          controller: tapTopModel.scrollController,
                          slivers: <Widget>[
                            //当有非sliver widget需要 appbar折叠时，则需要下面adapter
                            SliverToBoxAdapter(),
                            SliverAppBar(
                              actions: <Widget>[
                                EmptyAnimatedSwitcher(
                                  display: tapTopModel.showTopBtn,
                                  child: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: (){
                                      showSearch(
                                          context: context,
                                          delegate: DefaultSearchDelegate());
                                    },
                                  ),
                                ),
                              ],
                              //可折叠区域
                              flexibleSpace: prefix0.FlexibleSpaceBar(
                                background: BannerWidget(),
                                centerTitle: true,
                                title: GestureDetector(
                                  onDoubleTap: tapTopModel.scrollToTop(),
                                  child: EmptyAnimatedSwitcher(
                                    display: tapTopModel.showTopBtn,
                                    child: Text(S.of(context).appName),
                                  ),
                                ),
                              ),
                              expandedHeight: bannerHeight,
                              pinned: true,
                            ),
                            SliverPadding(
                              padding: prefix0.EdgeInsets.only(top: 5),
                            ),
                            /// listview 顶部的 指定文章
                            if (homeModel.idle) HomeTopArticleList(),
                            /// lsitview 的 普通文章list
                            HomeArticleList(),
                          ],
                        ),
                      ));
                },
              )),
          floatingActionButton: ScaleAnimatedSwitcher(
            child: tapTopModel.showTopBtn &&
                      homeModel.refreshController.headerStatus !=
                          RefreshStatus.twoLevelOpening
                ? prefix0.FloatingActionButton(
              heroTag: 'homeEmpty',
              key: ValueKey(Icons.vertical_align_top),
              onPressed: (){
                tapTopModel.scrollToTop();
              },
              child: Icon(Icons.vertical_align_top),
            ) : prefix0.FloatingActionButton(
              heroTag: 'homeFab',
              key: ValueKey(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: DefaultSearchDelegate());
              },
              child: Icon(
                Icons.search
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HomeArticleList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    HomeModel homeModel = Provider.of(context);

    if(homeModel.busy){
      ///加载数据时，先显示骨架图
      return SliverToBoxAdapter(
        child: ViewStateSkeletonList(
          builder: (context,index)=>ArticleSkeletonItem(),
        ),
      );


    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context,index){
            Article item = homeModel.list[index];
            return ArticleItemWidget(item,index: index,);
          },
        childCount: homeModel.list?.length ?? 0,
      ),
    );
  }

}


class HomeTopArticleList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //根据context 取到 同一个model，保持数据一致性
    HomeModel homeModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context,index){
            Article item = homeModel.topArticles[index];
            return ArticleItemWidget(
              item,index: index,top: true,
            );
          },
          childCount:homeModel.topArticles?.length ?? 0,
      ),
    );
  }

}


class BannerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AspectRatio(
      aspectRatio:  16 / 9,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: prefix0.Theme.of(context).scaffoldBackgroundColor
        ),
        child: Consumer<HomeModel>(builder: (_,homeModel,__){
          if(homeModel.busy){
            return CupertinoActivityIndicator();
          }else{
            var banners = homeModel?.banners ?? [];
            return Swiper(
              loop: true,
              autoplay: true,
              autoplayDelay: 5000,
              pagination: SwiperPagination(),
              itemCount: banners.length,
              itemBuilder: (ctx,index){
                return prefix0.InkWell(
                  onTap: (){
                    var banner = banners[index];
                    Navigator.of(context)
                        .pushNamed(RouteName.articleDetail,
                                  arguments: Article()
                                              ..id = banner.id
                                              ..title = banner.title
                                              ..link = banner.url
                                              ..collect = false);
                  },
                  child: BannerImage(banners[index].imagePath),
                );
              },
            );
          }
        },),
      ),
    );
  }

}
















