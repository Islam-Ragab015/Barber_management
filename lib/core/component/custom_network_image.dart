import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.length > 5) {
      return CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: CustomColors.KshimmerBaseColor,
          highlightColor: CustomColors.KshimmerHighlightColor,
          child: Container(
            color: Colors.grey,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey,
          child: const Center(
            child: Icon(
              Icons.error_outline,
              size: 40,
              color: Colors.red,
            ),
          ),
        ),
      );
    }
    return Container(
      color: Colors.grey,
      child: const Center(
        child: Icon(
          Icons.hide_image_outlined,
          size: 40,
          color: Color.fromARGB(83, 14, 13, 13),
        ),
      ),
    );
  }
}
