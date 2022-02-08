import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_event/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImagesWidget extends StatefulWidget {
  final String image;
  final double? height;
  final double? width;

  const ImagesWidget({
    Key? key,
    required this.image,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ImagesWidgetState createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(
        days: 15,
      ),
      maxNrOfCacheObjects: 100,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: (widget.image),
      key: UniqueKey(),
      alignment: Alignment.center,
      height: widget.height,
      width: widget.width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: imageProvider,
            alignment: Alignment.center,
          ),
        ),
      ),
      fit: BoxFit.fill,
      cacheManager: customCacheManager,
      placeholder: (context, url) => Container(
        color: Colors.grey.shade300,
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.black12,
        child: Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
            size: 2 * SizeConfig.textMultiplier!,
          ),
        ),
      ),
    );
  }
}
