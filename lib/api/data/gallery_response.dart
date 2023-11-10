// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'gallery_response.g.dart';

// ignore: public_member_api_docs
@JsonSerializable(explicitToJson: true)
class GalleryResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'likes')
  final int? likes;
  @JsonKey(name: 'user')
  final UserResponse? user;
  @JsonKey(name: 'urls')
  final UrlsResponse? urls;

  const GalleryResponse({
    required this.id,
    required this.likes,
    required this.user,
    required this.urls,
  });

  factory GalleryResponse.fromJson(Map<String, dynamic> json) => _$GalleryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UrlsResponse {
  @JsonKey(name: 'full')
  final String? full;

  const UrlsResponse({
    required this.full,
  });

  factory UrlsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UrlsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserResponse {
  @JsonKey(name: 'name')
  final String? name;

  const UserResponse({
    required this.name,
  });

  factory UserResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
