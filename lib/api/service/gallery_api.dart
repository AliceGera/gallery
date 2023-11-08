// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter_template/api/data/gallery_response.dart';
import 'package:flutter_template/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'gallery_api.g.dart';
/// Интерфейс API клиента.
@RestApi()
abstract class GalleryApi {
  factory GalleryApi(Dio dio) = _GalleryApi;

  // ignore: public_member_api_docs
  @GET(GalleryApiStrings.photos)
  Future<List<GalleryResponse>> getGallery(
    @Queries() Map<String, dynamic> queries,
  );
}
