// ignore_for_file: public_member_api_docs

class User {
  final String name;

  // ignore: public_member_api_docs
  User({
    required this.name,
  });

  User copyWith({
    String? name,
  }) {
    return User(
      name: name ?? this.name,
    );
  }
}
