// ignore_for_file: public_member_api_docs

import 'package:flutter_template/features/common/domain/data/urls_data.dart';
import 'package:flutter_template/features/common/domain/data/user_data.dart';

class Gallery {
  final String id;
  final int likes;
  final User user;
  final Urls urls;

  // ignore: public_member_api_docs
  Gallery({
    required this.id,
    required this.likes,
    required this.user,
    required this.urls,
  });

  Gallery copyWith({
    String? id,
    int? likes,
    User? user,
    Urls? urls,
  }) {
    return Gallery(
      id: id ?? this.id,
      likes: likes ?? this.likes,
      user: user ?? this.user,
      urls: urls ?? this.urls,
    );
  }
}
