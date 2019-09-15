import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_funandroid/config/resource_namager.dart';


enum ImageType{
  normal,
  random,
  assets,
}


class WrapperImage extends StatelessWidget{
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageType imageType;

  WrapperImage(
      {@required this.url,
        @required this.width,
        @required this.height,
        this.imageType: ImageType.normal,
        this.fit: BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (_,__) => ImageHelper.placeHolder(width: width,height: height),
      errorWidget: (_,__,___) => ImageHelper.error(width: width,height: height) ,
      fit: fit,
    );
  }

  String get imageUrl{
    switch(imageType){
      case ImageType.assets:
          return ImageHelper.wrapAssets(url);
      case ImageType.normal:
        return url;
      case ImageType.random:
        return ImageHelper.randomUrl(
          key:url,width:width.toInt(),height:height.toInt();
        );
    }
    return url;
  }

}














