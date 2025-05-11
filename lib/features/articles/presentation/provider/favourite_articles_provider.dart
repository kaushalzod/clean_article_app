import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/usecases/add_favourite_article_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/get_favourite_article_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/is_favourite_article_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/remove_favourite_article_usecase.dart';
import 'package:flutter/foundation.dart';

enum FavouriteArticlesStatus { initial, loading, success, error }

class FavouriteArticlesProvider with ChangeNotifier {
  final GetFavouriteArticleUsecase getFavouriteArticleUsecase;
  final AddFavouriteArticleUsecase addFavouriteArticleUsecase;
  final IsFavouriteArticleUsecase isFavouriteArticleUsecase;
  final RemoveFavouriteArticleUsecase removeFavouriteArticleUsecase;

  FavouriteArticlesProvider({
    required this.getFavouriteArticleUsecase,
    required this.addFavouriteArticleUsecase,
    required this.isFavouriteArticleUsecase,
    required this.removeFavouriteArticleUsecase,
  });

  FavouriteArticlesStatus status = FavouriteArticlesStatus.initial;
  String errorMessage = '';

  List<Article> favouriteArticles = [];

  void getFavouriteArticles() async {
    status = FavouriteArticlesStatus.loading;
    notifyListeners();

    var result = await getFavouriteArticleUsecase();

    _foldResult(result);
    notifyListeners();
  }

  void addFavouriteArticle(Article article) async {
    status = FavouriteArticlesStatus.loading;
    notifyListeners();

    var result = await addFavouriteArticleUsecase(article);

    _foldResult(result);
    notifyListeners();
  }

  void removeFavouriteArticle(Article article) async {
    status = FavouriteArticlesStatus.loading;
    notifyListeners();

    var result = await removeFavouriteArticleUsecase(article);

    _foldResult(result);
    notifyListeners();
  }

  void _foldResult(Either<Failure, List<Article>> result) {
    result.fold(
      (l) {
        status = FavouriteArticlesStatus.error;
        errorMessage = l.errorMessage;
        favouriteArticles = [];
      },
      (r) {
        status = FavouriteArticlesStatus.success;
        errorMessage = '';
        favouriteArticles = r;
        print(favouriteArticles);
      },
    );
  }
}
