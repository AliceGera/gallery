// ignore_for_file: public_member_api_docs

class Urls {
  final String full;

  // ignore: public_member_api_docs
  Urls({
    required this.full,
  });

  Urls copyWith({
    String? full,
  }) {
    return Urls(
      full: full ?? this.full,
    );
  }
}
