import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:flutter/material.dart' as prefix0;
import 'package:provider/provider.dart';
import 'package:flutter_app_funandroid/flutter/search.dart';//自定义 search// widget改自源码
import 'package:flutter_app_funandroid/view_model/search_model.dart';

import 'search_results.dart';
import 'search_suggestions.dart';

//自定义一个 search widget

class DefaultSearchDelegate extends SearchDelegate{

  SearchHistoryModel _searchHistoryModel = SearchHistoryModel();
  SearchHotKeyModel _searchHotKeyModel = SearchHotKeyModel();


  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    var theme = Theme.of(context);
    return super.appBarTheme(context).copyWith(
      primaryColor: theme.scaffoldBackgroundColor,
      primaryColorBrightness:theme.brightness
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
        prefix0.IconButton(
          icon: prefix0.Icon(Icons.clear),
          onPressed: (){
            if(query.isEmpty){
              close(context, null);
            }else {
              query = '';
              showSuggestions(context);
            }
          },
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return prefix0.IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    debugPrint('buildResults-query' + query);
    if (query.length > 0) {
      return SearchResult(
          keyWord: query, searchHistoryModel: _searchHistoryModel);
    }
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchHistoryModel>.value(
            value: _searchHistoryModel),
        ChangeNotifierProvider<SearchHotKeyModel>.value(
            value: _searchHotKeyModel),
      ],
      child: SearchSuggestions(delegate: this),
    );
  }
}