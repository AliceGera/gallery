// ignore_for_file: public_member_api_docs

class Gallery {
  final String id;
  final int likes;
  final String name;
  final String url;

  // ignore: public_member_api_docs
  Gallery({
    required this.id,
    required this.likes,
    required this.name,
    required this.url,
  });

  Gallery copyWith({
    String? id,
    int? likes,
    String? name,
    String? url,
  }) {
    return Gallery(
      id: id ?? this.id,
      likes: likes ?? this.likes,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
