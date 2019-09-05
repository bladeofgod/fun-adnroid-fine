import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';


const kAnimAddFavouritesTag = 'kAnimAddFavouritesTag';


class FavouriteAnimationWidget extends StatefulWidget{


  /// Hero动画的唯一标识
  final Object tag;

  /// true 添加到收藏,false从收藏移除
  final bool add;

  FavouriteAnimationWidget({@required this.tag,@required this.add});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FavouriteAnimationWidgetState();
  }

}

class FavouriteAnimationWidgetState extends State<FavouriteAnimationWidget> {

  bool playing = false;

  @override
  void initState() {
    // TODO: implement initState
    ///
    WidgetsBinding.instance.addPostFrameCallback((_){
      ///每帧绘制完成后 会调用此方法，详情参见 源文档注释
      setState(() {
        playing = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: widget.tag,
      child: FlareActor(
        ///由 flare 制作
          "assets/animations/like.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: widget.add ? 'like' : 'unLike',
        shouldClip: false,
        isPaused: !playing,
        callback: (name) {
          Navigator.pop(context);
          playing = false;
        },
      ),
    );
  }
}
/// Dialog下使用Hero动画的路由
///
///
class HeroDialogRoute<T> extends PageRoute<T>{
  final WidgetBuilder builder;

  HeroDialogRoute({this.builder}) : super();

  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black12;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return builder(context);
  }

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(milliseconds: 800);

}

















