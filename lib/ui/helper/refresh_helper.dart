import 'package:flutter/material.dart';
import 'package:flutter_app_funandroid/generated/i18n.dart';
import 'package:flutter_app_funandroid/ui/page/tab/home_second_floor_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


/// 首页列表的header


class HomeRefreshHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClassicHeader(
      idleText: S.of(context).refreshIdle,
      releaseText: S.of(context).refreshRefreshWhenRelease,
      refreshingText: S.of(context).refreshing,
      completeText: S.of(context).refreshComplete,
      canTwoLevelText: S.of(context).refreshTwoLevel,
      textStyle: TextStyle(color: Colors.white),
      //超出区域后，进入到二层
      outerBuilder: (child) => HomeSecondFloorOuter(child),
      twoLevelView: Container(),
    );
  }


}


/// 通用的footer
///
/// 由于国际化需要context的原因,所以无法在[RefreshConfiguration]配置
class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      failedText: S.of(context).loadMoreFailed,
      idleText: S.of(context).loadMoreIdle,
      loadingText: S.of(context).loadMoreLoading,
      noDataText: S.of(context).loadMoreNoData,
    );
  }
}











































