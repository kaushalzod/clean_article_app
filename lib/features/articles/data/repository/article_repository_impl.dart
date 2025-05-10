import 'package:article_app/core/model/either.dart';
import 'package:article_app/core/model/failure.dart';
import 'package:article_app/features/articles/data/datasource/local_favourite_articles_datasource.dart';
import 'package:article_app/features/articles/data/datasource/remote_articles_datasource.dart';
import 'package:article_app/features/articles/data/model/article_model.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final LocalFavouriteArticlesDatasource localDatasource;
  final RemoteArticlesDatasource remoteDatasource;

  ArticleRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      final articles = await remoteDatasource.getArticles();
      return Right(articles);
    } catch (e) {
      return Left(e is Failure ? e : ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Article>> getArticleById(int id) async {
    try {
      final article = await remoteDatasource.getArticleById(id);
      return Right(article);
    } catch (e) {
      return Left(e is Failure ? e : ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getFavouriteArticles() async {
    try {
      final article = await localDatasource.getFavouriteArticles();
      return Right(article);
    } catch (e) {
      return Left(e is Failure ? e : ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavouriteArticle(int id) async {
    try {
      final article = await localDatasource.isFavouriteArticle(id);
      return Right(article);
    } catch (e) {
      return Left(e is Failure ? e : ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchArticles(String query) async {
    try {
      final articles = await remoteDatasource.searchArticles(query);
      return Right(articles);
    } catch (e) {
      return Left(e is Failure ? e : ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> addFavouriteArticle(
    Article article,
  ) async {
    try {
      final articles = await localDatasource.addFavouriteArticles(
        ArticleModel.fromEntity(article),
      );
      return Right(articles);
    } catch (e) {
      return Left(e is Failure ? e : ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> removeFavouriteArticle(
    Article article,
  ) {
    // TODO: implement removeFavouriteArticle
    throw UnimplementedError();
  }
}
