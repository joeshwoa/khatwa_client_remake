import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khatwa_client/Core/helper/error_message_custom.dart';
import 'package:khatwa_client/Core/helper/loading_custom.dart';

class CachedImageCustom extends StatelessWidget {
  final BoxFit? boxFit;
  final String image;
  final double? width;
  final double? height;

  CachedImageCustom({Key? key, required this.image,  this.width,  this.height,this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      fit: boxFit??BoxFit.fill,
      placeholder: (context, url) => LoadingCustom(size: width != null && height != null ? (width! < height! ? (width!/3) : (height!/3)) : 30,),
      errorWidget: (context, url, error) {
        return ErrorMessageCustom(message: error.toString());
      },
    );
  }
}
