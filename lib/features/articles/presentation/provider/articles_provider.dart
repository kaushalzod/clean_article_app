import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/usecases/get_articles_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/search_articles_usecase.dart';
import 'package:flutter/widgets.dart';

enum ArticlesStatus { initial, loading, searchLoading, success, error }

class ArticlesProvider with ChangeNotifier {
  final GetArticlesUsecase getArticlesUsecase;
  final SearchArticlesUsecase searchArticlesUsecase;

  ArticlesProvider({
    required this.getArticlesUsecase,

    required this.searchArticlesUsecase,
  }) {
    controller.addListener(_onSearchChanged);
  }

  ArticlesStatus status = ArticlesStatus.initial;
  String errorMessage = '';
  TextEditingController controller = TextEditingController();

  List<Article> articles = [];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 0) {
      getArticles();
    }
    controller.clear();
    notifyListeners();
  }

  Future<void> getArticles() async {
    status = ArticlesStatus.loading;
    notifyListeners();

    var result = await getArticlesUsecase();

    _foldResult(result);
    notifyListeners();
  }

  Future<void> pullToRefresh() async {
    if (currentIndex == 0) getArticles();
    if (currentIndex == 1) searchArticles(controller.text);
  }

  void searchArticles(String query) async {
    if (query.trim().isEmpty) return;
    status = ArticlesStatus.searchLoading;
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

  void _onSearchChanged() {
    final query = controller.text.trim();
    if (query.isNotEmpty) {
      searchArticles(query);
    } else {
      getArticles();
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    super.dispose();
  }
}
