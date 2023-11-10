import 'package:flutter_template/api/data/gallery_response.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/domain/data/urls_data.dart';
import 'package:flutter_template/features/common/domain/data/user_data.dart';

/// Map [GalleryResponse] to [Gallery]
Gallery mapResponseToGallery(GalleryResponse response) {
  return Gallery(
    id: response.id ?? '',
    likes: response.likes ?? 0,
    urls: Urls(full: response.urls?.full ?? ''),
    user: User(name: response.user?.name ?? ''),
  );

}
