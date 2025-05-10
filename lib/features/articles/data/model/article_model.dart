import 'package:article_app/features/articles/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.body,
    required super.id,
    required super.title,
    required super.userId,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'body': body, 'title': title, 'userId': userId};
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      body: json["body"],
      id: json["id"],
      title: json["title"],
      userId: json["userId"],
    );
  }

  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      body: article.body,
      id: article.id,
      title: article.title,
      userId: article.userId,
    );
  }
}
