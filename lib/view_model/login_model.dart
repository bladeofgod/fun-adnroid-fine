import 'package:flutter_app_funandroid/config/storage_manager.dart';
import 'package:flutter_app_funandroid/provider/view_state_model.dart';
import 'package:flutter_app_funandroid/service/wan_android_repository.dart';

import 'user_model.dart';

const String kLoginName = 'kLoginName';


class LoginModel extends ViewStateModel{
  final UserModel userModel;
  LoginModel(this.userModel) : assert(userModel != null);

  String getLoginName(){
    return StorageManager.sharedPreference.getString(kLoginName);
  }

  Future<bool> login(loginName,password)async{
    setBusy(true);
    try{
      var user = await WanAndroidRepository.login(loginName, password);
      userModel.saveUser(user);
      StorageManager.sharedPreference.setString(kLoginName, userModel.user.username);
      setBusy(false);
      return true;
    }catch(e){
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }

  Future<bool> logout()async{
    if(!userModel.hasUser){
      //防止递归
      return false;
    }
    setBusy(true);
    try{
      await WanAndroidRepository.logout();
      userModel.clearUser();
      setBusy(false);
      return true;
    }catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }

}
























