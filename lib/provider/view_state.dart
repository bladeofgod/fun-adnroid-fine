
/*
* 定义数据状态，最底层
* 并catch 异常
* */


enum ViewState{
  idle,busy,empty,error,unAuthorized
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception{
  const UnAuthorizedException();

  @override
  String toString() =>'UnAuthorizedException';

}
































