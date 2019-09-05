import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
///

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget{
  final Widget Function(BuildContext context, T model,Widget chil) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;//数据准备完毕后，调用此方法


  ProviderWidget({Key key,this.builder,this.model,this.child,this.onModelReady})
    :super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProviderWidgetState();
  }

}

class ProviderWidgetState<T extends ChangeNotifier> extends
State<ProviderWidget<T>> {

  T model;

  @override
  void initState() {
    // TODO: implement initState

    model = widget.model;
    if(widget.onModelReady != null){
      widget.onModelReady(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //内部builder用来消费外层 provider 提供的model
    //此处builder 实际上是一个页面
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: widget.child,
    );
  }
}


class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
  extends StatefulWidget{
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
  builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelReady;

  ProviderWidget2({
    Key key,
    this.builder,
    this.model1,
    this.model2,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProviderWidget2State();
  }

}

class ProviderWidget2State<A extends ChangeNotifier,B extends ChangeNotifier> extends
State<ProviderWidget2> {

  A model1;
  B model2;

  @override
  void initState() {
    // TODO: implement initState
    model1  =widget.model1;
    model2 = widget.model2;

    if(widget.onModelReady != null){
      widget.onModelReady(model1,model2);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            builder: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            builder: (context) => model2,
          )
        ],
        //内部builder用来消费外层 provider 提供的model
        //此处builder 实际上是一个页面
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
  }






























