// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/constant/image_path.dart';

class CustomCircleAvatar extends StatelessWidget {
  double? radius;

  String? images;
  String? imageUrl;

  CustomCircleAvatar({
    Key? key,
    required this.radius,
    this.images,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl.toString() != "null"
          ? CachedNetworkImageProvider(
              imageUrl.toString(),
            ) as ImageProvider
          : AssetImage(images ?? AppAssets.loginlogo),
    );
  }
}
