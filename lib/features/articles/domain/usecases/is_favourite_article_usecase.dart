import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/repositories/article_repository.dart';

class IsFavouriteArticleUsecase {
  final ArticleRepository articleRepository;

  IsFavouriteArticleUsecase(this.articleRepository);

  Future<Either<Failure, bool>> call(int id) async {
    return articleRepository.isFavouriteArticle(id);
  }
}
