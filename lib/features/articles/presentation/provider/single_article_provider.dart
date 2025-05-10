import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/usecases/get_article_by_id_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/is_favourite_article_usecase.dart';
import 'package:flutter/material.dart';

enum SingleArticleStatus { initial, loading, success, error }

class SingleArticleProvider extends ChangeNotifier {
  final GetArticleByIdUsecase getArticleByIdUsecase;
  final IsFavouriteArticleUsecase isFavouriteArticleUsecase;

  SingleArticleProvider({
    required this.getArticleByIdUsecase,
    required this.isFavouriteArticleUsecase,
  });

  SingleArticleStatus status = SingleArticleStatus.initial;
  String errorMessage = '';

  Article? articles;

  void getArticleById(int id) async {
    status = SingleArticleStatus.loading;
    notifyListeners();

    final result = await getArticleByIdUsecase(id);
    final isFavourite = await isFavouriteArticleUsecase(id);

    result.fold(
      (l) {
        status = SingleArticleStatus.error;
        errorMessage = l.errorMessage;
        articles = null;
      },
      (r) {
        status = SingleArticleStatus.success;
        errorMessage = '';
        isFavourite.fold(
          (l) => articles = r,
          (check) => articles = r.copyWith(isFavourite: check),
        );
      },
    );
    notifyListeners();
  }
}
