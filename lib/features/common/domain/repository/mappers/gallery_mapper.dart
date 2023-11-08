import 'package:flutter_template/api/data/gallery_response.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';

/// Map [GalleryResponse] to [Gallery]
Gallery mapResponseToGallery(GalleryResponse response) {
  return Gallery(
    id: response.id,
    likes: response.likes,
    name: response.name ?? '',
    url: response.url,
  );
}
