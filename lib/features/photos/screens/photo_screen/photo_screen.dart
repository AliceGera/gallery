import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/photos/screens/photo_screen/photo_screen_wm.dart';

/// Main widget for PhotoScreen feature.
@RoutePage(
  name: AppRouteNames.photoScreen,
)
class PhotoScreen extends ElementaryWidget<IPhotoScreenWidgetModel> {
  /// Create an instance [PhotoScreen].
  const PhotoScreen({
    Key? key,
    WidgetModelFactory wmFactory = photoScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotoScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        closeScreen: wm.closeScreen,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;

  const _Body({
    required this.closeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  Images.img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              InkWell(
                onTap: closeScreen,
                child: const Padding(
                  padding: EdgeInsets.only(left: 26, top: 46),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 26),
            child: Text(
              'Christian',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6, left: 26),
            child: Text(
              '14 likes',
              style: TextStyle(
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
