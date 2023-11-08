// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

// ignore: public_member_api_docs
@JsonSerializable()
class GalleryResponse {
  final String id;
  final int likes;
  final String? name;
  final String url;

  const GalleryResponse({
    required this.id,
    required this.likes,
    required this.name,
    required this.url,
  });

  factory GalleryResponse.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final likes = json['likes'] as int;
    final user = json['user'] as Map;
    final name = user['name'] as String?;
    final urls = json['urls'] as Map;
    final url = urls['full'] as String;

    return GalleryResponse(
      id: id,
      likes: likes,
      name: name,
      url: url,
    );
  }
}
