// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/config/urls.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/service/gallery_service.dart';
import 'package:flutter_template/features/common/service/theme/theme_service.dart';
import 'package:flutter_template/features/debug/screens/debug_screen/debug_screen_widget_model.dart';
import 'package:flutter_template/features/photos/screens/gallery_screen/gallery_screen.dart';
import 'package:flutter_template/persistence/storage/config_storage/config_storage.dart';

/// Model fol [GalleryScreen].
class GalleryScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final GalleryService _galleryService;

  /// Environment configuration.
  final Environment _environment;

  final IThemeService _themeService;

  /// Callback to rebuild the whole application.
  final VoidCallback _applicationRebuilder;

  final IConfigSettingsStorage _configSettingsStorage;

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;

  /// Theme mode change Notifier.
  late ValueNotifier<ThemeMode> currentThemeMode;

  /// Config proxy url value.
  String? get proxyUrl => _environment.config.proxyUrl;

  /// Create an instance [GalleryScreenModel].
  GalleryScreenModel(
    this.errorHandler,
    this._environment,
    this._applicationRebuilder,
    this._configSettingsStorage,
    this._themeService,
    this._galleryService,
  ) : super(errorHandler: errorHandler);

  Future<List<Gallery>> getGalleryList(/*int count, [int offset = 0]*/) async {
    try {
      final List<Gallery> gallery;
      gallery = await _galleryService.getGallery(/*count, offset*/);
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

  /// Switch server.
  void switchServer(UrlType urlType) {
    AppConfig newConfig;
    switch (urlType) {
      case UrlType.test:
        newConfig = configNotifier.value.copyWith(url: Url.testUrl);
      case UrlType.prod:
        newConfig = configNotifier.value.copyWith(url: Url.prodUrl);
      default:
        newConfig = configNotifier.value.copyWith(url: Url.devUrl);
    }
    _refreshApp(newConfig);
  }

  /// Change proxyUrl value.
  void setProxy(String? proxyUrl) {
    _refreshApp(
      configNotifier.value.copyWith(proxyUrl: proxyUrl),
    );
  }

  /// Set theme mode for app.
  void setThemeMode(ThemeMode themeMode) {
    _themeService.updateThemeMode(themeMode);
  }

  void _refreshApp(AppConfig newConfig) {
    _setConfig(newConfig);
    _applicationRebuilder();
  }

  // ignore: use_setters_to_change_properties
  Future<void> _setConfig(AppConfig newConfig) async {
    _environment.config = newConfig;
    await _environment.saveConfigProxy(_configSettingsStorage);
  }

  void _environmentChangedCallback() {
    configNotifier.value = _environment.config;
  }

  void _updateTheme() {
    currentThemeMode.value = _themeService.currentThemeMode;
  }
}
