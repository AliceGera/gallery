// ignore_for_file: public_member_api_docs

import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/domain/repository/gallery_repository.dart';

class GalleryService {
  final GalleryRepository _galleryRepository;

  GalleryService(this._galleryRepository);

  Future<List<Gallery>> getGallery(/*Gallery gallery*/) async {
    return _galleryRepository.getGalleryList(/*gallery*/);
  }
}
