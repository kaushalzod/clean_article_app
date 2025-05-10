import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/repositories/article_repository.dart';

class SearchArticlesUsecase {
  final ArticleRepository articleRepository;

  SearchArticlesUsecase(this.articleRepository);

  Future<Either<Failure, List<Article>>> call(String query) async {
    return await articleRepository.searchArticles(query);
  }
}
