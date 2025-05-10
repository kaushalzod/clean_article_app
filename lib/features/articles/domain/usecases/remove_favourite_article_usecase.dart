import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/repositories/article_repository.dart';

class RemoveFavouriteArticleUsecase {
  final ArticleRepository articleRepository;

  RemoveFavouriteArticleUsecase(this.articleRepository);

  Future<Either<Failure, List<Article>>> call(Article article) async {
    return await articleRepository.removeFavouriteArticle(article);
  }
}
