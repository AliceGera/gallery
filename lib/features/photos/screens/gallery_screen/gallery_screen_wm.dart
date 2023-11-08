// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/service/gallery_service.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/photos/screens/gallery_screen/gallery_screen.dart';
import 'package:flutter_template/features/photos/screens/gallery_screen/gallery_screen_model.dart';
import 'package:flutter_template/persistence/storage/config_storage/config_storage_impl.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

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

  /// Create an instance [GalleryScreenModel].
  GalleryScreenWidgetModel(
    super._model,
    this.router,
    this._galleryService,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
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
  void openPhoto() {
    router.push(PhotoRouter());
  }

  Future<void> _getAllGalleryList(/*int offset*/) async {
    await model.getGalleryList(/*placeCount, offset*/).then(
      (content) async {
        await Future<void>.delayed(const Duration(seconds: 2));
        _listGalleryState.content(content);
      },
    );
  }

  @override
  GalleryService get galleryService => _galleryService;

  @override
  ListenableState<EntityState<List<Gallery>>> get listGalleryState => _listGalleryState;
}

/// Interface of [GalleryScreenWidgetModel].
abstract class IGalleryScreenWidgetModel extends IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}

  /// Navigate to log history screen.
  void openPhoto();

  /// Places service.
  GalleryService get galleryService;

  ListenableState<EntityState<List<Gallery>>> get listGalleryState;
}
