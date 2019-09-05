import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_funandroid/config/resource_namager.dart';



class BannerImage extends StatelessWidget{

  final String url;
  final Boxfit fit;


  BannerImage(this.url,{this.fit : BoxFit.fill});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CachedNetworkImage(
      imageUrl:  ImageHelper.wrapUrl(url),
      placeholder: (context,url)=>
          Center(child: CupertinoActivityIndicator(),),
      errorWidget: (context,url,error) => Icon(Icons.error),
      fit: fit,
    );
  }

}