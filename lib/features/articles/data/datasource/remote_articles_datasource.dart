import 'package:article_app/core/model/failure.dart';
import 'package:article_app/core/network/dio_client.dart';
import 'package:article_app/features/articles/data/model/article_model.dart';

class RemoteArticlesDatasource {
  final DioClient dioClient;

  RemoteArticlesDatasource(this.dioClient);

  ///  Get all articles from API
  Future<List<ArticleModel>> getArticles() async {
    try {
      var result = await dioClient.get("/posts");
      if (result.statusCode == 200) {
        final List jsonList = (result.data as List);
        return jsonList.map((item) => ArticleModel.fromJson(item)).toList();
      } else {
        throw ServerFailure(
          errorMessage: "Failed to load articles: ${result.statusCode}",
        );
      }
    } on Exception catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  ///  Search articles from API by title or body
  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      var result = await dioClient.get("/posts?title_like=^$query");
      if (result.statusCode == 200) {
        final List jsonList = (result.data as List);
        return jsonList.map((item) => ArticleModel.fromJson(item)).toList();
      } else {
        throw ServerFailure(
          errorMessage: "Failed to load articles: ${result.statusCode}",
        );
      }
    } on Exception catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  ///  Get specific article by id from API
  Future<ArticleModel> getArticleById(int id) async {
    try {
      var result = await dioClient.get("/posts/$id");
      if (result.statusCode == 200) {
        return ArticleModel.fromJson(result.data);
      } else {
        throw ServerFailure(
          errorMessage: "Failed to load article id - $id: ${result.statusCode}",
        );
      }
    } on Exception catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }
}
