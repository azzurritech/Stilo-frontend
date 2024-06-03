import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage cacheNetworkWidget(
  BuildContext context, {
  required String imageUrl,
}) {
  return CachedNetworkImage(
    // imageUrl: imageUrl,

    imageUrl: imageUrl,

    fit: BoxFit.cover,
    errorListener: (value) {
      log(value.toString());
    },
    useOldImageOnUrlChange: false,
    progressIndicatorBuilder: (context, url, progress) {
      return Center(
          child: CircularProgressIndicator.adaptive(
        value: progress.progress,
      ));
    },
    errorWidget: (context, url, error) {
      return const Icon(Icons.error);
    },
  );
}

ImageProvider<CachedNetworkImageProvider> cachedNetworkImageProvider({
  required String imageUrl,
}) {
  return CachedNetworkImageProvider(
    imageUrl,
  );
}
