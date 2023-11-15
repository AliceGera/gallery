// ignore_for_file: public_member_api_docs

import 'package:flutter_template/api/service/gallery_api.dart';
import 'package:flutter_template/features/common/domain/data/gallery_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/gallery_mapper.dart';

class GalleryRepository {
  late final GalleryApi _apiClient;

  GalleryRepository(this._apiClient);

  Future<List<Gallery>> getGalleryList(int count, [int offset = 0]) async {
    final queries = <String, dynamic>{
      'count': '$count',
      'offset': '$offset',
    };
    return _apiClient.getGallery({
      'client_id': 'RjiNZ5Z_-RVVdWB2okLb5yRWqn_HZhxI6gNZ8eMrQtQ',
      ...queries,
    }).then(
      (value) => value.map<Gallery>(mapResponseToGallery).toList(),
    );
  }
}
