import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;


  const CustomNetworkImage(
    this.imageUrl, {
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      useOldImageOnUrlChange: true,
      httpHeaders: {"meassage": imageUrl},
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator.adaptive(
              value: progress.downloaded.toDouble()),
        );
      },

      errorWidget: (context, url, error) {
        return Container();
      },
      fit: fit,
      height: height,
      width: width,
      color: color,
      // colorBlendMode: colorBlendMode,
    );
  }
}
