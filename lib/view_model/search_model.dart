import 'dart:async';


import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_funandroid/provider/view_state_model.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_funandroid/model/search.dart';
import 'package:flutter_app_funandroid/provider/view_state_refresh_list_model.dart';
import 'package:flutter_app_funandroid/provider/view_state_list_model.dart';
import 'package:flutter_app_funandroid/service/wan_android_repository.dart';

const String kLocalStorageSearch = 'kLocalStorageSearch';
const String kSearchHotList = 'kSearchHotList';
const String kSearchHistory = 'kSearchHistory';

class SearchHotKeyModel extends ViewStateListModel{
  @override
  Future<List> loadData() async{
    // TODO: implement loadData
    LocalStorage localStorage = LocalStorage(kLocalStorageSearch);
    await localStorage.ready;

    List localList = (localStorage.getItem(kSearchHotList) ?? [])
        .map<SearchHotKey>((item){
          return SearchHotKey.fromMap(item);
    }).toList();

    if(localList.isEmpty){
      //缓存为空,需要同步加载网络数据
      List netList = await WanAndroidRepository.fetchSearchHotKey();
      localStorage.setItem(kSearchHotList, netList);
      return netList;
    }else{
      WanAndroidRepository.fetchSearchHotKey().then((netList){
        netList = netList ?? {};
        if(!ListEquality().equals(netList, localList)){
          list = netList;
          localStorage.setItem(kSearchHotList, list);
          setBusy(false);
        }
      });
      return localList;
    }


  }
  shuffle(){
    //洗牌
    list.shuffle();
    notifyListeners();
  }

}


class SearchHistoryModel extends ViewStateListModel<String>{

  clearHistory()async{
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(kSearchHistory);
    list.clear();
    setEmpty();
  }

  addHistory(String keyword)async{
    var sharedPreferences = await SharedPreferences.getInstance();
    var histories = sharedPreferences.getStringList(kSearchHistory) ?? [];
    histories
        ..remove(keyword)
        ..insert(0, keyword);
    await sharedPreferences.setStringList(kSearchHistory, histories);
    notifyListeners();
  }

  @override
  Future<List<String>> loadData() async{
    // TODO: implement loadData
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(kSearchHistory) ?? [];
  }

}

class SearchResultModel extends ViewStateRefreshListModel{

  final String keyword;
  final SearchHistoryModel searchHistoryModel;

  SearchResultModel({this.keyword,this.searchHistoryModel});

  @override
  Future<List> loadData({int pageNum}) async{
    // TODO: implement loadData
    if(keyword.isEmpty) return[];
    return await WanAndroidRepository.fetchSearchResult(key: keyword,pageNum:
    pageNum);
  }

}






















