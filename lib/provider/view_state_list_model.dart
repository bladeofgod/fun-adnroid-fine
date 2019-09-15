import 'view_state_model.dart';

//列表页的基础封装

abstract class ViewStateListModel<T> extends ViewStateModel{
  //页面数据
  List<T> list= [];

  //第一次进入页面 loading skeleton
  initData() async{
    setBusy(true);
    await refresh(init:true);
  }
  //下拉刷新

  refresh({bool init = false})async{
    try{
      List<T> data = await loadData();
      if(data.isEmpty){
        setEmpty();
      }else{
        list = data;
        if(init){
          //改变页面状态为非加载中
          setBusy(false);
        }else{
          //调用刷新
          //此方法调用后，会刷新与provider绑定的widget
          notifyListeners();
        }

      }
    }catch(e,s){
      handleCatch(e, s);
    }
  }


  //加载数据

  Future<List<T>> loadData();




}

























