import 'package:flutter_app_funandroid/config/storage_manager.dart';
import 'package:flutter_app_funandroid/model/user.dart';
import 'package:flutter_app_funandroid/provider/view_state_model.dart';

///对model数据的 存取，并通过provider 供给外部消费

class UserModel extends ViewStateModel{
  static const String kUser = 'kUser';

  User _user;

  User get user => _user;

  bool get hasUser => user != null;
}