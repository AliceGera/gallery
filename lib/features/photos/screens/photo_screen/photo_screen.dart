// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/photos/screens/photo_screen/photo_screen_wm.dart';

/// Main widget for PhotoScreen feature.
@RoutePage(
  name: AppRouteNames.photoScreen,
)
class PhotoScreen extends ElementaryWidget<IPhotoScreenWidgetModel> {
  /// Create an instance [PhotoScreen].
  ///
  final String url;
  final String name;
  final int likes;

  const PhotoScreen(
    this.url,
    this.name,
    this.likes, {
    Key? key,
    WidgetModelFactory wmFactory = photoScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotoScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        url: url,
        name: name,
        likes: likes,
        closeScreen: wm.closeScreen,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;
  final String url;
  final String name;
  final int likes;

  const _Body({
    required this.closeScreen,
    required this.url,
    required this.name,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'hero-photo',
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: FadeInImage.assetNetwork(
                      image: url,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      placeholder: 'assets/images/loading1.gif',
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.black.withOpacity(0.03),
                ),
                child: InkWell(
                  onTap: closeScreen,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 26, top: 46),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                           shadows: <Shadow>[
                             Shadow(
                               offset: const Offset(3, 3),
                               blurRadius: 15,
                               color: Colors.black.withOpacity(.7),
                             ),
                           ],
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: const Offset(3, 3),
                                blurRadius: 15,
                                color: Colors.black.withOpacity(.7),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 26),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 26),
            child: Text(
              '$likes likes',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
