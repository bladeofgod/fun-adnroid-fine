
import 'package:flutter_app_funandroid/view_model/local_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_funandroid/view_model/theme_model.dart';
import 'package:flutter_app_funandroid/view_model/user_model.dart';

///向外部提供model
///可再次进行扩展
///目前控制着 user local theme
///
List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
  ChangeNotifierProvider<LocalModel>.value(value: LocalModel()),
  ChangeNotifierProvider<UserModel>.value(value: UserModel())
];

/// 需要依赖的model
List<SingleChildCloneableWidget> dependentServices = [
//  ProxyProvider<Api, AuthenticationService>(
//    builder: (context, api, authenticationService) =>
//        AuthenticationService(api: api),
//  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];