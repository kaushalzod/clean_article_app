import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/repositories/article_repository.dart';

class ToggleFavouriteArticleUsecase {
  final ArticleRepository articleRepository;

  ToggleFavouriteArticleUsecase(this.articleRepository);

  Future<Either<Failure, Article>> call() async {
    return await articleRepository.toggleFavouriteArticle();
  }
}
