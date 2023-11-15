// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/service/gallery_service.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/photos/screens/gallery_screen/gallery_screen.dart';
import 'package:flutter_template/features/photos/screens/gallery_screen/gallery_screen_model.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters
typedef OpenPhoto = void Function(String url, String name, int likes);

/// Factory for [GalleryScreenWidgetModel].
GalleryScreenWidgetModel galleryScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = GalleryScreenModel(
    appDependencies.errorHandler,
    Environment.instance(),
    appDependencies.themeService,
    appDependencies.galleryService,
  );
  final router = appDependencies.router;
  final galleryService = appDependencies.galleryService;
  return GalleryScreenWidgetModel(
    model,
    router,
    galleryService,
  );
}

/// Widget Model for [GalleryScreen].
class GalleryScreenWidgetModel extends WidgetModel<GalleryScreen, GalleryScreenModel> implements IGalleryScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;
  final GalleryService _galleryService;
  final _listGalleryState = EntityStateNotifier<List<Gallery>>();
  bool isLoading = false;
  bool isFirstLoading = true;
  int _offset = 0;
  bool isEnd = false;
  late ScrollController _controller;
  final List<Gallery> list = [];
  late ValueNotifier<bool> isValue;

  /// Create an instance [GalleryScreenModel].
  GalleryScreenWidgetModel(
    super._model,
    this.router,
    this._galleryService,
  );

  _scrollListener() async {
   if (_controller.position.extentAfter < 300) {
      await _getAllGalleryList();
    }
  }

  @override
  void initWidgetModel() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initWidgetModel();
    }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAllGalleryList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void openPhoto(String url, String name, int likes) {
    router.push(PhotoRouter(/*url:url,name,likes*/));
  }

  Future<void> _getAllGalleryList() async {
    if (kDebugMode) {
      print(111111);
    }
    if (!isLoading && !isEnd) {
      isLoading = true;
      if (isFirstLoading) {
        isFirstLoading = false;
        final galleryList = await model.getGalleryList(10, _offset);
        _listGalleryState.content(galleryList);
      } else {
        _offset += 10;
        final galleryList = await model.getGalleryList(10, _offset);
        if (galleryList.isEmpty) {
          isEnd = true;
        } else {
          list.addAll(galleryList);
          _offset = list.length;
          _listGalleryState.content(list);
        }
      }
      isLoading = false;
    }
  }

  @override
  GalleryService get galleryService => _galleryService;

  @override
  ScrollController get controller => _controller;

  @override
  bool get getIsEnd => isEnd;

  @override
  ListenableState<EntityState<List<Gallery>>> get listGalleryState => _listGalleryState;
}

/// Interface of [GalleryScreenWidgetModel].
abstract class IGalleryScreenWidgetModel extends IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}

  /// Navigate to log history screen.
  void openPhoto(String url, String name, int likes);

  ScrollController get controller;

  bool get getIsEnd;

  /// Places service.
  GalleryService get galleryService;

  ListenableState<EntityState<List<Gallery>>> get listGalleryState;
}
