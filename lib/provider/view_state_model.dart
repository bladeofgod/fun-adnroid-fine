import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'view_state.dart';

///继承change notifier 协调provider 对数据进行刷新
///最底层 viewmodel
/// 所有请求网络数据的页面，基本都继承自 此widget（也就是带有 empty  busy error等状态的）
/// 对于 列表页 或者普通页面，可以继承此类，之后再针对不同的页面需求，进行再次封装
class ViewStateModel with ChangeNotifier{
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

/// 根据状态构造
///
/// 子类可以在构造函数指定需要的页面状态
/// FooModel():super(viewState:ViewState.busy);
///
  ViewStateModel({ViewState viewState})
  : _viewState = viewState ?? ViewState.idle;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState){
    _viewState = viewState;
    ///刷新view
    notifyListeners();
  }


/// 出错时的message
  String _errorMessage;
  String get errorMessage => _errorMessage;

/// 以下变量是为了代码书写方便,加入的变量.严格意义上讲,并不严谨
///
  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;


  void setBusy(bool value){
    _errorMessage = null;
    viewState = value ? ViewState.busy : ViewState.idle;
  }


  void setEmpty(){
    _errorMessage = null;
    viewState = ViewState.empty;
  }

  void setUnAuthorized(){
    _errorMessage = null;
    viewState = ViewState.unAuthorized;
  }

  void setError(String message) {
    _errorMessage = message;
    viewState = ViewState.error;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'BaseModel{_viewState: $viewState, _errorMessage: $_errorMessage}';
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if(!_disposed){
      //避免异常，重写此方法
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

/// Handle Error and Exception
///
/// 统一处理子类的异常情况
/// [e],有可能是Error,也有可能是Exception.所以需要判断处理
/// [s] 为堆栈信息
///

  void handleCatch(e,s){
    // DioError的判断,理论不应该拿进来,增强了代码耦合性,抽取为时组件时.应移除
    if(e is DioError && e.error is UnAuthorizedException){
      setUnAuthorized();
    }else{
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      setError(e is Error ? e.toString() : e.message);
    }
  }

}

























