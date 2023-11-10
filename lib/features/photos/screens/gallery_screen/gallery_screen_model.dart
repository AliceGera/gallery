// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/service/gallery_service.dart';
import 'package:flutter_template/features/common/service/theme/theme_service.dart';
import 'package:flutter_template/features/photos/screens/gallery_screen/gallery_screen.dart';

/// Model fol [GalleryScreen].
class GalleryScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final GalleryService _galleryService;

  /// Environment configuration.
  final Environment _environment;

  final IThemeService _themeService;


  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;

  /// Theme mode change Notifier.
  late ValueNotifier<ThemeMode> currentThemeMode;

  /// Create an instance [GalleryScreenModel].
  GalleryScreenModel(
    this.errorHandler,
    this._environment,
    this._themeService,
    this._galleryService,
  ) : super(errorHandler: errorHandler);

  Future<List<Gallery>> getGalleryList(int count, [int offset = 0]) async {
    try {
      final List<Gallery> gallery;
      gallery = await _galleryService.getGallery(count, offset);
      return gallery;
    } on Object catch (error) {
      rethrow;
    }
  }

  @override
  void init() {
    configNotifier = ValueNotifier<AppConfig>(_environment.config);
    currentThemeMode = ValueNotifier<ThemeMode>(_themeService.currentThemeMode);
    _themeService.addListener(_updateTheme);
    _environment.addListener(_environmentChangedCallback);
  }

  @override
  void dispose() {
    _environment.removeListener(_environmentChangedCallback);
    _themeService.removeListener(_updateTheme);
  }

  /// Set theme mode for app.
  void setThemeMode(ThemeMode themeMode) {
    _themeService.updateThemeMode(themeMode);
  }

  void _environmentChangedCallback() {
    configNotifier.value = _environment.config;
  }

  void _updateTheme() {
    currentThemeMode.value = _themeService.currentThemeMode;
  }
}
