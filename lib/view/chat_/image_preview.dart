import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:photo_view/photo_view.dart';

import '../../utils/constant/colors.dart';

class ImagePreview extends StatelessWidget {
  static const routeName = '/imagePreview';
  const ImagePreview({
    super.key,
    required this.image,

    // required this.maxImages, this.image,
  });
  final image;
  // final int maxImages;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          allowImplicitScrolling: true,
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return PhotoView(
              minScale: PhotoViewComputedScale.contained * 1,
              imageProvider: CachedNetworkImageProvider(image),
            );
          },
          // controller: PageController(initialPage: maxImages, keepPage: false),
        ),
        Positioned(
          left: 15,
          top: MediaQuery.of(context).padding.top + 15,
          child: GestureDetector(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.black26, shape: BoxShape.circle),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: AppColor.textcolor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
