import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/photos/screens/photo_screen/photo_screen.dart';
import 'package:flutter_template/features/photos/screens/photo_screen/photo_screen_model.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [PhotoScreenWidgetModel].
PhotoScreenWidgetModel photoScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final model = PhotoScreenModel();
  final router = appDependencies.router;
  return PhotoScreenWidgetModel(model, router);
}

/// Widget Model for [PhotoScreen].
class PhotoScreenWidgetModel extends WidgetModel<PhotoScreen, PhotoScreenModel> implements IPhotoScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  late final AppRouter router;

  /// Create an instance [PhotoScreenModel].
  PhotoScreenWidgetModel(
    super._model,
    this.router,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }
}

/// Interface of [PhotoScreenWidgetModel].
abstract class IPhotoScreenWidgetModel extends IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
}
