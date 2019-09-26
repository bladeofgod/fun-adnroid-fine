import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app_funandroid/generated/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_funandroid/config/resource_namager.dart';
import 'package:flutter_app_funandroid/flutter/search.dart';
import 'package:flutter_app_funandroid/model/search.dart';
import 'package:flutter_app_funandroid/provider/view_state_list_model.dart';
import 'package:flutter_app_funandroid/view_model/search_model.dart';



class SearchSuggestions<T> extends StatelessWidget{

  final SearchDelegate<T> delegate;

  SearchSuggestions({@required this.delegate});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(
      builder: (BuildContext context,BoxConstraints viewportConstraints){
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:viewportConstraints.maxHeight,
              minWidth: viewportConstraints.maxWidth
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(opacity: 0.6,
                    size: 16),
                child: MultiProvider(
                  providers: [
                    Provider<TextStyle>.value(value: prefix0.Theme.of
                      (context).textTheme.body1),
                    ProxyProvider<TextStyle,Color>(
                      builder: (context,textStyle,_)=>
                              textStyle.color.withOpacity(0.5),
                    ),
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SearchHotKeysWidget(delegate: delegate,),
                      SearchHistoriesWidget(delegate: delegate,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}


class SearchHotKeysWidget extends StatefulWidget{

  final SearchDelegate delegate;

  SearchHotKeysWidget({@required this.delegate , key}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchHotKeysWidgetState();
  }

}

class SearchHotKeysWidgetState extends State<SearchHotKeysWidget> {

  @override
  void initState() {
    // TODO: implement initState
    //widget 准备好后 会调用此方法 具体 见注解
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Provider.of<SearchHotKeyModel>(context).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              prefix0.FlatButton(
                child: Text(
                  S.of(context).searchHot,
                  style: Provider.of<TextStyle>(context),
                ),
              ),
              Consumer<SearchHotKeyModel>(
                builder: (context,model,_){
                  return Visibility(
                    visible: ! model.busy,
                    child: model.idle ?
                      prefix0.FlatButton.icon(
                          textColor: Provider.of<Color>(context),
                          onPressed: model.shuffle(),
                        icon: Icon(
                          Icons.autorenew,
                        ),
                        label: Text(S.of(context).searchShake),)
                      : prefix0.FlatButton.icon(
                      textColor: Provider.of<Color>(context),
                      onPressed: model.initData(),
                      icon: Icon(Icons.refresh),
                      label: Text(S.of(context).retry),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SearchSuggestions(),
      ],
    );
  }
}

class SearchHistoriesWidget<T> extends StatefulWidget{
  final SearchDelegate<T> delegate;

  SearchHistoriesWidget({@required this.delegate,key})
    : super(key : key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchHistoriesWidgetState();
  }}

class SearchHistoriesWidgetState extends State<SearchHistoriesWidget> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Provider.of<SearchHistoryModel>(context).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              prefix0.FlatButton(
                child: Text(
                  S.of(context).searchHistory,
                  style: Provider.of<TextStyle>(context),
                ),
              ),
              Consumer<SearchHistoryModel>(
                builder: (context,model,child) => Visibility(
                  visible: !model.busy && !model.empty,
                  child: model.idle ?
                      prefix0.FlatButton.icon(
                        textColor: Provider.of<Color>(context),
                        onPressed: model.clearHistory(),
                        icon: Icon(Icons.clear),
                        label: Text(S.of(context).clear),
                      ):prefix0.FlatButton.icon(
                      textColor: Provider.of<Color>(context),
                      onPressed: model.initData,
                      icon: Icon(Icons.refresh),
                      label: Text(S.of(context).retry)
                  ),
                ),
              ),
            ],
          ),
        ),
        SearchSuggestionsStateWidget<SearchHistoryModel,String>(
          builder: (context,item) => prefix0.ActionChip(
            label: Text(item),
            onPressed: (){
              widget.delegate.query = item;
              widget.delegate.showResults(context);
            },
          ),
        )
      ],
    );
  }
}



class SearchSuggestionsStateWidget<T extends ViewStateListModel,E>
    extends StatelessWidget{

  final Widget Function(BuildContext context, E data) builder;

  SearchSuggestionsStateWidget({@required this.builder});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<T>(
      builder: (context,model,_)
          =>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: model.idle ?
                  Wrap(
                      alignment: WrapAlignment.start,
                    spacing: 10,
                    children: List.generate(model.list.length, (index){
                      E item = model.list[index];
                      //外部 传进来的 builder 进行item UI 构造
                      return builder(context,item);
                    }),
                  ) : Container(
                    padding:  EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
              child: Builder(builder: (context){
                  if(model.busy){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: CupertinoActivityIndicator(),
                    );
                  }else if(model.error){
                    return const Icon(
                      IconFonts.pageError,
                      size: 60,
                      color: Colors.grey,
                    );
                  }else if(model.empty){
                    return const Icon(
                      IconFonts.pageEmpty,
                      size: 70,
                      color: Colors.grey,
                    );
                  }
                  return SizedBox.shrink();
              },),
            ),
          ),
    );
  }

}





































