import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/usecases/is_favourite_article_usecase.dart';
import 'package:flutter/material.dart';

enum SingleArticleStatus { initial, loading, success, error }

class SingleArticleProvider extends ChangeNotifier {
  final IsFavouriteArticleUsecase isFavouriteArticleUsecase;

  SingleArticleProvider({required this.isFavouriteArticleUsecase});

  SingleArticleStatus status = SingleArticleStatus.initial;
  String errorMessage = '';

  Article? articles;

  Future<void> getArticleById(Article article) async {
    articles = article;
    status = SingleArticleStatus.loading;
    notifyListeners();

    final isFavourite = await isFavouriteArticleUsecase(article.id);

    isFavourite.fold(
      (l) {},
      (check) => articles = articles?.copyWith(isFavourite: check),
    );
    notifyListeners();
  }
}
