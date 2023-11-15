import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/photos/screens/gallery_screen/gallery_screen_wm.dart';

/// Main widget for PhotosScreen feature.
@RoutePage(
  name: AppRouteNames.galleryScreen,
)
class GalleryScreen extends ElementaryWidget<IGalleryScreenWidgetModel> {
  /// Create an instance [GalleryScreen].
  const GalleryScreen({
    Key? key,
    WidgetModelFactory wmFactory = galleryScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGalleryScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        openPhoto: wm.openPhoto,
        wm: wm,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final OpenPhoto openPhoto;
  final IGalleryScreenWidgetModel wm;

  const _Body({
    required this.openPhoto,
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: wm.controller,
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white.withOpacity(0.75),
          pinned: true,
          expandedHeight: 140,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final statusBarHeight = MediaQuery.of(context).viewPadding.top;
                  final appBarPinnedHeight = kToolbarHeight + statusBarHeight;
                  final percentage = ((constraints.maxHeight - appBarPinnedHeight) / (98 - appBarPinnedHeight)).clamp(0.0, 1.0);
                  final titleSize = Tween<double>(begin: 14, end: 30).transform(percentage);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment(-1 * percentage, 0.5),
                      child: Text(
                        'Title',
                        style: TextStyle(fontSize: titleSize),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        StateNotifierBuilder<EntityState<List<Gallery>>>(
          listenableState: wm.listGalleryState,
          builder: (_, galleryList) {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                childCount: galleryList?.data?.length ?? 0,
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              openPhoto(
                                galleryList?.data?[index].urls.full ?? '',
                                galleryList?.data?[index].user.name ?? '',
                                galleryList?.data?[index].likes ?? 0,
                              );
                            },
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: ColoredBox(
                                        color: Colors.white,
                                        child: FadeInImage.assetNetwork(
                                          image: galleryList?.data?[index].urls.full ?? '',
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          placeholder: 'assets/images/loading1.gif',
                                          height: 158,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          galleryList?.data?[index].user.name ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${galleryList?.data?[index].likes ?? 0} likes',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: Center(
            child: wm.getIsEnd ? const Text('') : const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
