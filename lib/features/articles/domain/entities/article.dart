class Article {
  final int id;
  final int userId;
  final String body;
  final String title;
  final bool isFavourite;

  Article({
    required this.id,
    required this.userId,
    required this.body,
    required this.title,
    this.isFavourite = false,
  });

  Article copyWith({
    int? id,
    int? userId,
    String? body,
    String? title,
    bool? isFavourite,
  }) {
    return Article(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      body: body ?? this.body,
      title: title ?? this.title,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
