// ignore_for_file: public_member_api_docs

import 'package:flutter_template/api/service/gallery_api.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/gallery_mapper.dart';

class GalleryRepository {
  late final GalleryApi _apiClient;

  GalleryRepository(this._apiClient);

  Future<List<Gallery>> getGalleryList(/*Gallery gallery*/) async {
    return _apiClient.getGallery({
      'client_id': '896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043',
    }).then(
      (value) => value.map<Gallery>(mapResponseToGallery).toList(),
    );
  }
}
