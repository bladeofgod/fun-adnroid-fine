import 'article.dart';


class NavigationSite{


  List<Article> articles;
  int cid;
  String name;


  static NavigationSite fromMap(Map<String,dynamic> map){
    if(map == null) return null;
    NavigationSite naviBean = NavigationSite();
    naviBean.articles = List()
    ..addAll(
      // 这里通过？？ 进行了判空
        (map['articles'] as List ?? [])
            .map((o) => Article.fromMap(o)));
    naviBean.cid = map['cid'];
    naviBean.name = map['name'];
    return naviBean;
  }


  Map toJson() => {
    "articles": articles,
    "cid": cid,
    "name": name,
  };

}