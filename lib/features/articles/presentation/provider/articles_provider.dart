import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/usecases/get_articles_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/search_articles_usecase.dart';
import 'package:flutter/foundation.dart';

enum ArticlesStatus { initial, loading, success, error }

class ArticlesProvider with ChangeNotifier {
  final GetArticlesUsecase getArticlesUsecase;
  final SearchArticlesUsecase searchArticlesUsecase;

  ArticlesProvider({
    required this.getArticlesUsecase,

    required this.searchArticlesUsecase,
  });

  ArticlesStatus status = ArticlesStatus.initial;
  String errorMessage = '';

  List<Article> articles = [];

  void getArticles() async {
    status = ArticlesStatus.loading;
    notifyListeners();

    var result = await getArticlesUsecase();

    _foldResult(result);
    notifyListeners();
  }

  void searchArticles(String query) async {
    if (query.trim().isEmpty) return;
    status = ArticlesStatus.loading;
    notifyListeners();

    var result = await searchArticlesUsecase(query.trim());

    _foldResult(result);
    notifyListeners();
  }

  void _foldResult(Either<Failure, List<Article>> result) {
    result.fold(
      (l) {
        status = ArticlesStatus.error;
        errorMessage = l.errorMessage;
        articles = [];
      },
      (r) {
        status = ArticlesStatus.success;
        errorMessage = '';
        articles = r;
      },
    );
  }
}
