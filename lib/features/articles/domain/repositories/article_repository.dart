import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';

abstract class ArticleRepository {
  /// Returns List of all the articles from remote data source
  Future<Either<Failure, List<Article>>> getArticles();

  /// Return specific article by its id
  Future<Either<Failure, Article>> getArticleById(int id);

  /// Search Articles by title or body
  Future<Either<Failure, List<Article>>> searchArticles(String query);

  /// Get List of all the Favourite Articles
  Future<Either<Failure, List<Article>>> getFavouriteArticles();

  /// Add favourite article in local data source
  Future<Either<Failure, List<Article>>> addFavouriteArticle(Article article);

  /// Remove favourite article in local data source
  Future<Either<Failure, List<Article>>> removeFavouriteArticle(
    Article article,
  );

  /// Returns bool if given article id is marked as favourite
  Future<Either<Failure, bool>> isFavouriteArticle(int id);
}
