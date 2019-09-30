import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_funandroid/provider/provider_widget.dart';
import 'package:flutter_app_funandroid/provider/view_state_list_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_funandroid/flutter/dropdown.dart';
import 'package:flutter_app_funandroid/model/tree.dart';
import 'package:flutter_app_funandroid/model/tree.dart';
import 'package:flutter_app_funandroid/provider/view_state_widget.dart';
import 'package:flutter_app_funandroid/view_model/project_model.dart';

import '../article_list_page.dart';




class ProjectPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectPageState();
  }

}

class ProjectPageState extends State<ProjectPage> with AutomaticKeepAliveClientMixin{


  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;

  @override
  void dispose() {
    // TODO: implement dispose
    valueNotifier.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<ProjectCategoryModel>(
      model: ProjectCategoryModel(),
      onModelReady: (model){
        model.initData();
      },
      builder: (context,model,child){
        if(model.busy){
          return Center(child: CircularProgressIndicator(),);
        }
        if(model.error){
          return ViewStateWidget(onPressed: model.initData(),);
        }

        List<Tree> treeList = model.list;
        var primaryColor = Theme.of(context).primaryColor;

        return ValueListenableProvider<int>.value(
          value: valueNotifier,
          child: DefaultTabController(
            length: model.list.length,
            initialIndex: valueNotifier.value,
            child: Builder(
              builder: (context){
                if(tabController == null){
                  tabController = DefaultTabController.of(context);
                  tabController.addListener((){
                    valueNotifier.value = tabController.index;
                  });
                }
                return Scaffold(
                  appBar: AppBar(
                    title: Stack(
                      children: <Widget>[
                        CategoryDropdownWidget(
                          Provider.of<ProjectCategoryModel>(context)
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 25),
                          color: primaryColor.withOpacity(1),
                          child: TabBar(
                            isScrollable: true,
                            tabs:List.generate(treeList.length, (index){
                              return Tab(text: treeList[index].name,);
                            })
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: List.generate(treeList.length, (index){
                      return ArticleListPage(treeList[index].id);
                    }),
                  ),
                );
              },
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


class CategoryDropdownWidget extends StatelessWidget{

  final ViewStateListModel model;

  CategoryDropdownWidget(this.model);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int currentIndex = Provider.of<int>(context);
    return Align(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:Theme.of(context).primaryColor,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            elevation: 0,
            value: currentIndex,
            style: Theme.of(context)
                      .primaryTextTheme.subhead,
            items: List.generate(model.list.length, (index){
              var theme = Theme.of(context);
              var subhead = theme.primaryTextTheme.subhead;
              return DropdownMenuItem(
                value: index,
                child: Text(
                  model.list[index].name,
                  style: currentIndex == index
                        ? subhead.apply(color: theme.brightness == Brightness
                      .light ? Colors.white : theme.accentColor)
                    : subhead.apply(color: subhead.color.withAlpha(200)),
                ),
              );
            }),
            onChanged: (value){
              DefaultTabController.of(context).animateTo(value);
            },
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
        ),
      ),
      alignment: Alignment(1.1,-1),
    );
  }

}































